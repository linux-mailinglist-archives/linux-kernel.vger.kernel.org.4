Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DE56B05ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCHL0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHLZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:25:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529577B4B4;
        Wed,  8 Mar 2023 03:25:28 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328BC6X7017137;
        Wed, 8 Mar 2023 11:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tvru8B3sS/iOpKm1/IurwLaLFrvKe6AbFP3B7G4NMZ4=;
 b=a2m8dNv6x3wOoZtX2RBTLpH+U2RXZp1hfGZvSutp9E3aR7wwGxpHdGFjPXtnYaqECCm4
 NVmfRmMGjPFStmfZ6Pj+bLDpP4xGWGDJXwkHemj+8mX+QBgkya1ZFdC8Ga9coXcEKTls
 FL/4TlD/wG3UAoueYLcUyk/iTwRrADXyVPODTCWhO7r5Asckbjgn5xkDhrH4Xk/CUC2v
 uZk3T9yajMDERQxGcZ5lFdJu/e+nNk7bZqtcMTJdJEDONmGzfWQEvjhK/u/68i2WL1gf
 WNsXboPK9bJ7GuOcWwLv61TPwwpGGXbOMuqM5yJjiJQnXI0rRahIg9xRaRZKCjqPxqDp KA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6s9a098s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 11:24:50 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32817HHF015599;
        Wed, 8 Mar 2023 11:24:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p6gdq8fsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 11:24:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328BOjLX38732230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 11:24:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 890B42004B;
        Wed,  8 Mar 2023 11:24:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F272420040;
        Wed,  8 Mar 2023 11:24:44 +0000 (GMT)
Received: from [9.179.30.6] (unknown [9.179.30.6])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 11:24:44 +0000 (GMT)
Message-ID: <2e79ebb0ef62e550231c3daf46c62cd60d78acbc.camel@linux.ibm.com>
Subject: Re: [niks:has_ioport_v3] [tty] aa0652d7f1:
 BUG:kernel_NULL_pointer_dereference,address
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Date:   Wed, 08 Mar 2023 12:24:44 +0100
In-Reply-To: <e211f932-77c3-427a-859a-d846598524ed@app.fastmail.com>
References: <202301051008.a8468257-yujie.liu@intel.com>
         <e211f932-77c3-427a-859a-d846598524ed@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MkxQ5m4kcrMdgLGgKHCURS8o37G7R8Kb
X-Proofpoint-GUID: MkxQ5m4kcrMdgLGgKHCURS8o37G7R8Kb
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_06,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080097
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

Yes that makes sense, it's clearly not correct to put the default case
inside CONFIG_SERIAL_8250_RT288X. What do you think about going with
something like:

@@ -519,9 +534,14 @@ static void set_io_from_upio(struct uart_port *p)
 #endif

        default:
+#ifdef CONFIG_HAS_IOPORT
                p->serial_in =3D io_serial_in;
                p->serial_out =3D io_serial_out;
                break;
+#else
+               WARN(1, "Unsupported UART type \"io\"\n");
+               return;
+#endif
        }

I've pushed a version with the above change rebased on v6.3-rc1 to my
git.kernel.org repository and will do some more testing before I can
hopefully send this out for review and make some progress on this.
Meanwhile the original problem is now the only thing preventing clean
Werror builds on clang for s390 as far as I understand.

Thanks,
Niklas
