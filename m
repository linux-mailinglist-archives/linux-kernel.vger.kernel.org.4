Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E065AF48
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjABKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjABKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:06:35 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041831C3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:06:33 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0B88760003;
        Mon,  2 Jan 2023 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672653992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9D8Y+DBW+vGrczBNQRRDtRd16IJPcvgPJsKV94Z0guE=;
        b=HRMVRoBd4UF80iOc0qdYtbX+AWvmt4xXGGSZTO0v2LY/PQqtmGvtxeKi+kT9ACK12aNyxJ
        +XhGSUmbexgQgqNtYA2rly89LLpljCPVM6kw4biBbSxDjS86eO2rySrINbPLxU3sW1xNwq
        noKUVpK/Y5QzwgrRsoQmzrzwaiIH8HkQWdCGv2YtJRIJtU3ICH9455XpXYoxJnslyKYz+k
        AzZQoEOhq0GtBdtDRDiOKSUpOUE9PItqyr/05t2GnhG61lCluvjXoTQWIAHw29Cb5FGMSN
        ZPqz82f0lkrhxJXJejb4CiWOVTWIjoj+zkUhmKPlMY9rUCNJMxDcQSihzj18Rw==
Date:   Mon, 2 Jan 2023 11:06:30 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: rawnand: hynix: Add support for
 H27UCG8T2FTR-BC MLC NAND
Message-ID: <20230102110630.4c68e038@xps-13>
In-Reply-To: <1b17f332-827b-c8b1-807c-9c6e38caf173@sholland.org>
References: <20221229190906.6467-1-samuel@sholland.org>
        <20221229190906.6467-2-samuel@sholland.org>
        <20221230134507.719edeae@xps-13>
        <1b17f332-827b-c8b1-807c-9c6e38caf173@sholland.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

samuel@sholland.org wrote on Fri, 30 Dec 2022 10:08:13 -0600:

> Hi Miqu=C3=A8l,
>=20
> On 12/30/22 06:45, Miquel Raynal wrote:
> > Hi Samuel,
> >=20
> > samuel@sholland.org wrote on Thu, 29 Dec 2022 13:09:03 -0600:
> >  =20
> >> H27UCG8T2FTR-BC is similar to the already-supported H27UCG8T2ETR-BC, b=
ut
> >> reports a different ID. =20
> >=20
> > Can you provide a datasheet for this part? I am surprised by the page
> > size. In general anyway, it's best to provide a link when adding
> > support for a new component. =20
>=20
> I was unable to find a datasheet for specifically H27UCG8T2FTR-BC. The
> best datasheet I could find is for H27UCG8T2ETR-BC[0][1]. However, there
> are layout parameters for H27UCG8T2FTR-BC in some versions of the vendor
> NAND driver[2][3][4]. The Hynix chip is packaged as Essencore
> I3T-8GQ8T2H5TARC, as referenced in that NAND ID table, which is the
> actual package on the board I have.
>=20
> Regards,
> Samuel
>=20
> [0]:
> https://z3d9b7u8.stackpathcdn.com/pdf-down/H/2/7/H27UCG8T2ETR-BC-Hynix.pdf

Pointing to [0] or [1] in the commit log would be nice at least, even
though we cannot get our hands on the real datasheet...

> [1]: http://www.zsong.com.cn/userfiles/H27UC(D)G8T(U)2ETR-BC_Rev1.0_0826.=
pdf
> [2]:
> https://github.com/engSinteck/A133_Image/blob/main/longan/kernel/linux-4.=
9/modules/nand/sun8iw15p1/phy-nand/physic_v2/nand_id2.c#L1592
> [3]:
> https://github.com/launchfur/rg818-kernel/blob/master/modules/nand/sun8iw=
15p1/phy-nand/physic_v2/nand_id2.c#L1592
> [4]: Adding member names to that table entry:
>=20
> {.nand_id               =3D {0xad, 0xde, 0x14, 0xab, 0x42, 0x4a,
>                            0xff, 0xff},
>  .die_cnt_per_chip      =3D 1,
>  .sect_cnt_per_page     =3D 32,
>  .page_cnt_per_blk      =3D 256,
>  .blk_cnt_per_die       =3D 2112,
>  #define NAND_MULTI_PROGRAM (1 << 3)
>  #define NAND_RANDOM        (1 << 7)
>  #define NAND_READ_RETRY    (1 << 8)
>  #define NAND_LSB_PAGE_TYPE (0xff << 12)
>  .operation_opt         =3D 0x00002188,
>  .valid_blk_ratio       =3D 896,
>  .access_freq           =3D 40,
>  .ecc_mode              =3D 8,
>  .read_retry_type       =3D 0x050804,
>  .ddr_type              =3D 0,
>  .option_phyisc_op_no   =3D 14,
>  .ddr_info_no           =3D 0,
>  .id_number             =3D 0x010026,
>  .max_blk_erase_times   =3D 3000,
>  .driver_no             =3D 1,
>  .access_high_freq      =3D 40,
>  .random_cmd2_send_flag =3D 0,
>  .random_addr_num       =3D 0,
>  .nand_real_page_size   =3D 16384 + 1664},

This and what is displayed in the two datasheets pointed above looks
very much like out-of-band data to me, I don't get why we should treat
this part of the array differently? The OOB area is not only supposed to
be used for ECC bytes (even though that's how UBI make use of it), you
can store all the data you want there (but it's not necessarily
protected by the ECC engine, which, in general, matters a lot.

I don't see how this datasheet would be different than the others. They
don't detail the geometry, I would have expected them to do it if the
page size was anything different than the standard?

> ".option_phyisc_op_no =3D 14" references this entry:
> {
>     /* 14 */
>     .multi_plane_read_cmd =3D {0x60, 0x30},
>     .multi_plane_write_cmd =3D {0x11, 0x81},
>     .multi_plane_copy_read_cmd =3D {0x60, 0x60, 0x35},
>     .multi_plane_copy_write_cmd =3D {0x85, 0x11, 0x81},
>     .multi_plane_status_cmd =3D 0x78,
>     .inter_bnk0_status_cmd =3D 0x78,
>     .inter_bnk1_status_cmd =3D 0x78,
>     .bad_block_flag_position =3D 0x00,
>     .multi_plane_block_offset =3D 1024,
> },
>=20

Thanks,
Miqu=C3=A8l
