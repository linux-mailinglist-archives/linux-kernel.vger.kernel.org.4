Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0955EC23D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiI0MQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiI0MQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:16:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE1DB951
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:16:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w2so9556786pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yPFntR9/mCadEpXcQATRbftBmHGgFITCK1PZVUoDa5M=;
        b=VoBhv/vx3Dyt7a+5tjIrQKoiK/32bqqzw3DFhQAvIQ2U2NpI5Iwb9hblDSLjBWLbx0
         QcXEJS9r/0jsao3abY6q8eObMjMWLS9Q8JLerW+SpZ8e2pyURC8FkvrUTpEVyJVkRJWB
         mYtKPnyc8aLDh0k0jrdvKJO6mio0gVnymrCAKBdwzuyMQEQCQH3PeExl0F6dx32Wh+xM
         jiu/wdJHvEvNgTbzLboR4/0XQUgnaihG2KF038FWO+KLxKcoUQDxMuxcffKpLOL+Pe35
         dYYvp6/SuAPS3ZicYBV12uc2CJkQlo1Ukc7zm31KLa36sCIIQ/3cu66yreGo2g4jstjA
         M4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yPFntR9/mCadEpXcQATRbftBmHGgFITCK1PZVUoDa5M=;
        b=XjINy0FiKuqmBQnqG/hEKQqcEwOQsnV8wjPyc/2cqUSqkow2fPF/W7RKait1eS7Oc9
         iwWjWcFww/WLcwz4dFGxbPDwQO8I2i79WhoxH8loJChBcqICTM1c7RJIWJsCu+CTRdUj
         i2gz59iwUK2RnCetyTiVWhcjtGo+WjPVQAAmo+/73AqaBg8Vj4NaWDh47t69feZmnGgt
         RQTFhU5r1mAoWtlGsw9WM2jNAGC72MQfgIgrFsByYn+Tb2tCLrOY1X8JZ8ZbYFboZ6OW
         12KN89wEZRlcV3Qj+Ps079uyWw+zz4EFQPoHBb1Ec4p5ugoFPiaeL67Xvdn32/Cd9DT2
         jPLA==
X-Gm-Message-State: ACrzQf0umTEnY/Lh078mTdvH1p0W1VMP2fIwsWjKkg7Qy85UE7HiNhf+
        qm9DlxvbofjSlTtZWOPWgJ0=
X-Google-Smtp-Source: AMsMyM45fFoygZTDhSWITjzGqfccjFhrKypaNJiTaiNspHnLb45SDtZJgVq2ZW7hGYytwSOzCUGu6A==
X-Received: by 2002:a65:40c8:0:b0:434:dfee:8dc1 with SMTP id u8-20020a6540c8000000b00434dfee8dc1mr25088969pgp.156.1664280984637;
        Tue, 27 Sep 2022 05:16:24 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id y18-20020aa79432000000b0054087e1aea4sm1644771pfo.15.2022.09.27.05.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 05:16:23 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 31EE11004A5; Tue, 27 Sep 2022 19:16:19 +0700 (WIB)
Date:   Tue, 27 Sep 2022 19:16:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hwpoison: fix build error without
 CONFIG_MEMORY_FAILURE
Message-ID: <YzLpkmPrw0tbIo1W@debian.me>
References: <20220927102946.98622-1-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7Fj09Ln2Ru7zIzIm"
Content-Disposition: inline
In-Reply-To: <20220927102946.98622-1-tanghui20@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7Fj09Ln2Ru7zIzIm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 06:29:46PM +0800, Hui Tang wrote:
> Building without CONFIG_MEMORY_FAILURE will fail:
>=20
> mm/memory-failure.o: In function `action_result':
> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
> mm/memory-failure.o: In function `page_handle_poison':
> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
> mm/memory-failure.o: In function `__get_huge_page_for_hwpoison':
> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
> mm/memory-failure.o: In function `unpoison_memory':
> memory-failure.c: undefined reference to `memblk_nr_poison_sub'
> mm/memory-failure.o: In function `num_poisoned_pages_inc':
> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
>=20
> Add CONFIG_MEMORY_FAILURE wrapper for invoking memblk_nr_poison_{inc|sub}.
>=20

Better say "Guard memblk_nr_poison_{inc,sub} under CONFIG_MEMORY_FAILURE".

--=20
An old man doll... just what I always wanted! - Clara

--7Fj09Ln2Ru7zIzIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzLpjQAKCRD2uYlJVVFO
o9YBAQD/LB+J7Ig7JbBnO41XhpCDYSN+JBqJiiG4joXsED0x/QEA5/tSHh66ldz1
3wWSJzbXTRZedc5ywsbxCA8SFsrLowE=
=+nSn
-----END PGP SIGNATURE-----

--7Fj09Ln2Ru7zIzIm--
