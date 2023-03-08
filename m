Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E4D6B0A79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjCHOH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjCHOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:07:05 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B481B2E5;
        Wed,  8 Mar 2023 06:05:17 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328DJEc2027895;
        Wed, 8 Mar 2023 14:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zBXIcnb+DEc0lzd5ge6FUHpadrkeZ99ddpqiHCj3T1I=;
 b=jeTXmgcNtRqFX51cPfkyv9lWYxW1WhNiiFkdsmZLU9GIt7VGP9mP0TZHbVzyXrSAhXbu
 KQUQMR+Wuze8XMiFceWdW3NKe2S5P2h4KZ/RU/+uKFT1d2XuLjFStK9f27g2gYzbDwfv
 oFWQ7jKlSbOxCr2WxZTmhrI387846DDMURJiYOuROWYFpbqQwgP4mQO/9Ccwhh64klmv
 OzGsKQlfkc1ALylRfyybCHNBQzbjlzkBo2zyg1yicc+5kEIwYUxdRZcdi4xD85/GXXEU
 nWVGnhASYO1tRhTu1fxOY0hz3d6fBljbjClrFxSewq7EahrRTF6dxLQjZt2GH4JVZ+SL VQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6k0bvm7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 14:04:00 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328134ef015019;
        Wed, 8 Mar 2023 14:03:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3p6gbw8n10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 14:03:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328E3u6762587284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 14:03:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB39920043;
        Wed,  8 Mar 2023 14:03:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C1EE20040;
        Wed,  8 Mar 2023 14:03:55 +0000 (GMT)
Received: from [9.179.30.6] (unknown [9.179.30.6])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 14:03:55 +0000 (GMT)
Message-ID: <772a05f5f3c1b35864b80bf78429b843bdf14ee9.camel@linux.ibm.com>
Subject: Re: [niks:has_ioport_v3] [tty] aa0652d7f1:
 BUG:kernel_NULL_pointer_dereference,address
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Date:   Wed, 08 Mar 2023 15:03:55 +0100
In-Reply-To: <c85f0735-6c85-4a6e-ad07-66493783c58e@app.fastmail.com>
References: <202301051008.a8468257-yujie.liu@intel.com>
         <e211f932-77c3-427a-859a-d846598524ed@app.fastmail.com>
         <2e79ebb0ef62e550231c3daf46c62cd60d78acbc.camel@linux.ibm.com>
         <c85f0735-6c85-4a6e-ad07-66493783c58e@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A7twQW98j1zIbStxavky8neuXRkHbDHw
X-Proofpoint-GUID: A7twQW98j1zIbStxavky8neuXRkHbDHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-08 at 13:21 +0100, Arnd Bergmann wrote:
> On Wed, Mar 8, 2023, at 12:24, Niklas Schnelle wrote:
> > On Thu, 2023-01-05 at 09:03 +0100, Arnd Bergmann wrote:
> >=20
> > Yes that makes sense, it's clearly not correct to put the default case
> > inside CONFIG_SERIAL_8250_RT288X. What do you think about going with
> > something like:
> >=20
> > @@ -519,9 +534,14 @@ static void set_io_from_upio(struct uart_port *p)
> >  #endif
> >=20
> >         default:
> > +#ifdef CONFIG_HAS_IOPORT
> >                 p->serial_in =3D io_serial_in;
> >                 p->serial_out =3D io_serial_out;
> >                 break;
> > +#else
> > +               WARN(1, "Unsupported UART type \"io\"\n");
> > +               return;
> > +#endif
> >         }
>=20
> I think we have to ensure that ->serial_in() always points
> to some function that doesn't immediately panic, though that
> could be an empty dummy like
>=20
>        default:
>                p->serial_in =3D IS_ENABLED(CONFIG_HAS_IOPORT) ?
>                       io_serial_in : no_serial_in;
>                p->serial_out =3D IS_ENABLED(CONFIG_HAS_IOPORT) ?
>                       io_serial_out : no_serial_out;

Sadly the IS_ENABLED() plus ternary still gives me an undeclared
identifier error for io_serial_in(). So I think we need the more ugly
#ifdef. With that I hope it would then not crash even if one might be
left without any console at all.

>=20
> Ideally we'd make mem_serial_in() the default function
> and only use io_serial_in() when UPIO_PORT is selected,
> but that still causes a NULL pointer dereference when
> a platform initializes a 8250 like
>=20
> static struct plat_serial8250_port serial_platform_data[] =3D {
>         {
>                 .iobase         =3D 0x3f8, /* NULL pointer */
>                 .irq            =3D IRQ_ISA_UART,
>                 .uartclk        =3D 1843200,
>         /* default   .iotype         =3D UPIO_PORT, */
>         },
>=20
> so I think an empty function plus a warning is best here.

So in the above case .iotype is implicitly set to 0 which is UPIO_PORT
so I think one could argue it is selected, no? Not sure how picking
UPIO_MEM as default would look like then. One thing we could do though
is make the switch/case more regular like so:

...
#ifdef CONFIG_HAS_IOPORT
	case UPIO_PORT:
		p->serial_in =3D io_serial_in;
		p->serial_out =3D io_serial_out;
		break;
#endif

	default:
		WARN(1, "Unsupported UART type %x\n", p->iotype);
		p->serial_in =3D no_serial_in;
		p->serial_out =3D no_serial_out;
	}
...

That way we would have to always define no_serial_in() /
no_serial_out() but would also gracefully handle when p->iotype is set
to some other value and it looks relatively clean.
