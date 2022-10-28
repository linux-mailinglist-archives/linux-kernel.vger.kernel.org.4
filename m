Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0C610B49
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJ1HaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJ1HaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:30:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44F3CBDD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:30:05 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S7E3xa019527;
        Fri, 28 Oct 2022 07:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=22ojzaejfatY0Mc3HvchrNvV8i8OCtp6rk/DAp/CDZU=;
 b=dmUbiYFutQrUplth8lgKLESBik4UjTG+a/aqjBi13wvdQId4f2GYmZxVQMnTLf1FWTBg
 qV+zwmnpzR52UhPYnGHYQCJ1DJz6QqCavRu/MgayoqsqdbfDkwQ07A5cuEBjEFRrBLa3
 MFYRmDWaC/EQuy5Otir08kuy3QJkeKDINJWQU61PfnhLCvXjrpB8B8Wb/1ZYG0pYVF5u
 MqqcLmNcRKRtDjU64W6nlkYkRTbNVpN3bpkTHZ0/NXWR1uewqrl+TZ+z/4fVTyAWS9FJ
 +Q62Enf8OJbq3uPUAJze1BFS6qgILRhDPx3JEgKMeGNkRt5pnwWWwteR6/Lxv7Cg9BUl Tw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgagvre8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:30:01 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29S7KJ12009913;
        Fri, 28 Oct 2022 07:29:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3kftf1sa2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:29:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29S7TvaV34734708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 07:29:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 161CC42041;
        Fri, 28 Oct 2022 07:29:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAE274203F;
        Fri, 28 Oct 2022 07:29:55 +0000 (GMT)
Received: from localhost (unknown [9.43.57.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 07:29:55 +0000 (GMT)
Date:   Fri, 28 Oct 2022 12:59:54 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Limit number of lines processed in
 'trace'
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Akanksha J N <akanksha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>
References: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
        <20221017105103.540a87c7@gandalf.local.home>
        <20221019001949.950fb044677f96c6cdd00fdf@kernel.org>
        <20221018112224.372a3484@gandalf.local.home>
        <1666172148.1jppmgndx2.naveen@linux.ibm.com>
        <20221020004607.a78c771e12ad0f65c018220b@kernel.org>
In-Reply-To: <20221020004607.a78c771e12ad0f65c018220b@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1666941493.vogf5bjzvv.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SbjuqP9yl8gKxTefSPWO9UAPYSQ2KAtG
X-Proofpoint-ORIG-GUID: SbjuqP9yl8gKxTefSPWO9UAPYSQ2KAtG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_03,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Wed, 19 Oct 2022 15:15:09 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Steven Rostedt wrote:
>> > On Wed, 19 Oct 2022 00:19:49 +0900
>> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>> >=20
>> >> > You need to make sure that the "pause-on-trace" option is set or tr=
acing_on
>> >> > is set to 0 (disabled). Otherwise, if the tracing is still active, =
then the
>> >> > reading of the trace file could potentially never end. =20
>> >>=20
>> >> initialize_ftrace() does this setting. So it must be set.
>> >> If you run the ftracetest on old kernel, this feature is not there an=
d
>> >> it may cause a trouble. Naveen, can you clarify it?
>>=20
>> Yes, the change to not pause on opening the trace file looks to be the=20
>> problem.
>>=20
>> >=20
>> > But for old kernels that do not have "pause-on-trace" it should be the
>> > default. The "pause-on-trace" was added when the default was changed t=
o not
>> > pause the trace while reading it.
>>=20
>> It looks like the kernel patch was picked up, but Masami's patch for the=
=20
>> selftest wasn't backported. I have requested a test with that applied.
>=20
> Good! That should be backported too.
> BTW, which kernel version do you test?

This was reported in internal tests with RHEL kernel.

>=20
>>=20
>> Separately, before I saw your response, I came up with the below patch=20
>> to update the selftests to disable tracing before reading the trace=20
>> file. I have also requested this to be tested.
>=20
> Yeah, OK. This also looks OK to me.

This patch doesn't seem to be enough - event/subsystem-enable.tc also=20
needs updates. In light of that, I'm not sure if the large number of=20
disable_tracing statements required makes sense. So, I'm inclined to=20
drop this patch in favour of the existing pause-on-trace option.


Thanks,
Naveen
