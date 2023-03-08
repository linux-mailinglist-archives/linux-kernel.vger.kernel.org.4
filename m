Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12066B0EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCHQ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCHQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:27:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6464BD2388;
        Wed,  8 Mar 2023 08:27:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CFC0B81DA4;
        Wed,  8 Mar 2023 16:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43349C43322;
        Wed,  8 Mar 2023 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678292833;
        bh=JbxCyI0huIIANoxirPXgBTBH1si+npk+dR+RaZC1gzg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YBZP76Ad87hnY4xkxLVRdMFSnnkcSazWx7ctmmBO3jZVceNLqFo7l/o98Wy2QDQu8
         KCm5hO2UoC4cgZ2At1VLFNv3t20NJCitR1wMZmwV6/Ijn6HFGydmu/pFkZA1hSQNaj
         2IoTojH/fyvBOxze9JfDeWsadU+aHiRwP58joHNRgUBdsiX77E3Ma64odWj+Pzxy2W
         pIKWg0AGt+xk1eakynuaU0yiixiUatM6EY+Enbosfw7gJ8C4PGlZRf8z9mkoDrZn9b
         OnX2dP6smKxPO9ltvuAks+krZ/DgL4wVuOT1A2Ni0y9iNvezRHmB1fAWkKR+Uwt5tp
         HipwG++0kQTKw==
Received: by mail-ed1-f46.google.com with SMTP id s11so68017420edy.8;
        Wed, 08 Mar 2023 08:27:13 -0800 (PST)
X-Gm-Message-State: AO0yUKU0JnYsfKLvI7blA3gH0Q3YrCLyiUt4NiGybm6C8ca59uDTg7hL
        pQrsWAh2lYdDJx3KUd5NVGP7PHukAruNxNMOvwQ=
X-Google-Smtp-Source: AK7set8tv9oj0Cs64+dvjPmRThogjRBhvrPYlr0s1Jxp6xg8NhIzAjly/ShQhG8oQbSbN3jKigayPafGtW24VNutDRs=
X-Received: by 2002:a17:906:9143:b0:8ad:d366:54c4 with SMTP id
 y3-20020a170906914300b008add36654c4mr12974560ejw.4.1678292831332; Wed, 08 Mar
 2023 08:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20230306160016.4459-1-tzimmermann@suse.de> <20230306160016.4459-23-tzimmermann@suse.de>
 <CAOZdJXUtkyg5Gv3HYCK-U1pQpY0_QBk99wtqUvz5RVy2W3Ak9w@mail.gmail.com> <aac88d8e-52e8-e2d5-2f41-bed7886bb3dc@suse.de>
In-Reply-To: <aac88d8e-52e8-e2d5-2f41-bed7886bb3dc@suse.de>
From:   Timur Tabi <timur@kernel.org>
Date:   Wed, 8 Mar 2023 10:26:34 -0600
X-Gmail-Original-Message-ID: <CAOZdJXWGNBHMPRmkBYeVL31=Q0Y=fLa8RG0KS668xQ9ozD+Xtg@mail.gmail.com>
Message-ID: <CAOZdJXWGNBHMPRmkBYeVL31=Q0Y=fLa8RG0KS668xQ9ozD+Xtg@mail.gmail.com>
Subject: Re: [PATCH 22/99] fbdev/fsl-diu-fb: Duplicate video-mode option string
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, adaplas@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, mbroemme@libmpq.org,
        thomas@winischhofer.net, James.Bottomley@hansenpartnership.com,
        spock@gentoo.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, geert+renesas@glider.be,
        corbet@lwn.net, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 2:28=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
> > So after module_init is finished, mode_option_buf[] no longer exists?
>
> Does the __init attribute on a function affect the static variables in
> that function?

That is an excellent question.

https://stackoverflow.com/questions/64558614/what-happens-to-local-static-i=
dentifiers-in-init-function

I don't think the compiler is naturally aware of whatever section a
variable or function is placed in, so it can't really know that
mode_option_buf[] is suppose to have a limited lifetime.

Either way, the code seems wrong.  If mode_option_buf[] is marked as
__initdata, then it will disappear before the probe() function is
called.

If mode_option_buf[] remains resident, then we are wasting 256 bytes.
