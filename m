Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9D6620AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjAIIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjAIIxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:53:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E9119C23;
        Mon,  9 Jan 2023 00:45:27 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3098dFOC016302;
        Mon, 9 Jan 2023 08:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3DGgtcvzBS3erm7QfVEqUU4i8HSjdPmckD78sbQivms=;
 b=g6MEUvRNhASqwdG5ZSL7HeG0KyFtF8g8Ar3RWDEC20VIQe5aevtT5jHvRgjz0ui6luQh
 dS7lk1GnVwO10hXJwxDirbAMfHJlIMDJ9A6JuV4l/bnP4AtMoB4JO/fXLYe3nIbG3ZAt
 +fc/Esw0Dtzy9/M3+tqc8OqSQThAl6ULQSViyfFPelQcE+5zAbvDuabYTN7wW4gbKM0b
 +T/7DRurUvFR2BFyLHfZVcz8Wexn0gLu8HDkmHpUeCDixMjqNeLK3lYAI4xnSoP/J2zD
 UobCrEVStkOXLzxek509BVdusQw0C7gV84EjsOV4UzQx5e+yHlwX2zoOE5x9tkB6lINk NA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myj6j81dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 08:45:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 308FR0aa000570;
        Mon, 9 Jan 2023 08:45:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6jmm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 08:45:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3098j4nu39518602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jan 2023 08:45:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C573B20043;
        Mon,  9 Jan 2023 08:45:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66A0C2004B;
        Mon,  9 Jan 2023 08:45:04 +0000 (GMT)
Received: from [9.171.86.101] (unknown [9.171.86.101])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jan 2023 08:45:04 +0000 (GMT)
Message-ID: <5f6a4b1e0a5a85f6e2e9f674bc88843c5ab623c6.camel@linux.ibm.com>
Subject: Re: [niks:has_ioport_v3] [tty] aa0652d7f1:
 BUG:kernel_NULL_pointer_dereference,address
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date:   Mon, 09 Jan 2023 09:45:04 +0100
In-Reply-To: <e211f932-77c3-427a-859a-d846598524ed@app.fastmail.com>
References: <202301051008.a8468257-yujie.liu@intel.com>
         <e211f932-77c3-427a-859a-d846598524ed@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hquSNgfW-DyJfvPVpS4omgMCJSc_qgmu
X-Proofpoint-GUID: hquSNgfW-DyJfvPVpS4omgMCJSc_qgmu
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_03,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-05 at 09:03 +0100, Arnd Bergmann wrote:
> On Thu, Jan 5, 2023, at 06:54, kernel test robot wrote:
> > Greeting,
> >=20
> > FYI, we noticed BUG:kernel_NULL_pointer_dereference,address due to=20
> > commit (built with clang-14):
> >=20
> > commit: aa0652d7f1b311e55232a8153522fdaaba0f197a ("tty: serial: handle=
=20
> > HAS_IOPORT dependencies")
> > https://git.kernel.org/cgit/linux/kernel/git/niks/linux.git=20
> > has_ioport_v3
> >=20
> > in testcase: boot
> >=20
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -=
m 4G
> >=20
> > caused below changes (please refer to attached dmesg/kmsg for entire=20
> > log/backtrace):
> >=20
> >=20
> > [    2.166733][    T0] calling  univ8250_console_init+0x0/0x30 @ 0
> > [    2.167555][    T0] BUG: kernel NULL pointer dereference, address:=20
> > 00000000
>=20
> I think it's this bit:
>=20
> @@ -508,12 +523,13 @@ static void set_io_from_upio(struct uart_port *p)
>                 up->dl_read =3D au_serial_dl_read;
>                 up->dl_write =3D au_serial_dl_write;
>                 break;
> -#endif
> -
> +#ifdef CONFIG_HAS_IOPORT
>         default:
>                 p->serial_in =3D io_serial_in;
>                 p->serial_out =3D io_serial_out;
>                 break;
> +#endif
> +#endif
>         }
>         /* Remember loaded iotype */
>         up->cur_iotype =3D p->iotype;
>=20
>=20
> which puts the 'default' case inside of '#ifdef
> CONFIG_SERIAL_8250_RT288X'. x86 does not use the
> RT288x variant but relies on the default, so any
> call to io_serial_{in,out} will cause a NULL
> pointer dereference.
>=20
>        Arnd

Thanks for looking into it Arnd, your reasoning makes sense to me, I'll
try to look into this and test this case before I sent out the v3 of
the HAS_IOPORT patches. I still also have a few nitpicks from Bjorn,
mostly about the commit messages, to work in. Hope to do that soon but
got a few things going on at the moment.
