Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F320169EFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBVICe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBVIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:02:29 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD937556;
        Wed, 22 Feb 2023 00:02:22 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ec43so26365606edb.8;
        Wed, 22 Feb 2023 00:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkBz8xtUcsBFti4NW0wUs7te3xGjoS+Aw/KAsmCJ7/U=;
        b=MtyB+AwDLBdx3hrWfMn72VuqABmErzodmuE1i59W7Hi0sCCtatLSn2V72gLtfFWuFZ
         Ck5bK8u5m3j5hVQb2vYZuoQnMwjQjDe+wkFGGGd2g5xq9tzFN1PgFQ1LohiPQNAOCtA3
         RGe03Y9ZkxGsnvcHBbKKA2s1MuvllsWVAWOB2XmcFjR+uJ3YKs/hOJhbFj3hvY7xMhPh
         tE6IIcOVl1jpvw3mVRBXc35nVN/N3PHS8ijqgnH8JHO2TrcBY0eKddLAEaOQJxNuR109
         JNFIvJLFfr+qenqBUShCSHs58EE0rWrkVN2ZlfS+WzxwoT+AhKeAY8xWDLtxps/6pQIc
         g/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkBz8xtUcsBFti4NW0wUs7te3xGjoS+Aw/KAsmCJ7/U=;
        b=yDdJ8lPHjxTBlw4ZYttYPv8tFDj702dzWkPAgpepuDY7c/b8QEdus7k0MjlSwH5b0e
         Evw2c6nRuDK6KGtencZzR7G5kJ3w5LAi1s/pveULBWu7hvvplv1xbHaOBZvdgORbEWy1
         V8PsFGHodLh4sqeXWR2JVdniqcfjMaPCfnoijbKEqrlkvIRBo9C8qMCzyizKEylBi+Oq
         Kj/jJcsbT7VHrb++0MrKelwFevrxb9AygLC8uYzulAmR4pGkkCAlgBsGinVk6qG8xX71
         bVMA/FRw63mfn/2i3ZxqyrU8KkKahF87EUogeVBrwQ36cQwfzMh9pUQkJyut0XARIXVB
         BWeg==
X-Gm-Message-State: AO0yUKX8T5EZt1emuG9zhSmTeLbyfzmtURus55A1+Mw9Hk5CQR1HQaRg
        CuaQ8wyMM5zt6WOWhq1QmCFKbcSLXR09SdlfIZU=
X-Google-Smtp-Source: AK7set+OD7llSTDXwShjal7nbjqlkhW7eI4nbra80LETlZs6z3mfM3l2ArA/FXd6lVClZCtzfeiiDMO4Tr8r58qn+Z4=
X-Received: by 2002:a17:906:5e5a:b0:877:747c:9745 with SMTP id
 b26-20020a1709065e5a00b00877747c9745mr7240950eju.8.1677052940625; Wed, 22 Feb
 2023 00:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20230221183211.21964-1-clamor95@gmail.com> <20230221183211.21964-8-clamor95@gmail.com>
 <Y/VFMl5Darm7YEK1@sirena.org.uk>
In-Reply-To: <Y/VFMl5Darm7YEK1@sirena.org.uk>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 22 Feb 2023 10:02:09 +0200
Message-ID: <CAPVz0n072v3XVt-Ogcx1QwBfEfOG4O7e8Ge9f3rpWOqU=44Qkw@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] ARM: tegra: transformers: update bindings of
 sound graph
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 22 =D0=BB=D1=8E=D1=82. 2023 =D1=80. =D0=BE 00:27 Mark Brown <=
broonie@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 21, 2023 at 08:32:08PM +0200, Svyatoslav Ryhel wrote:
> > - fix headset detection in common device tree;
>
> At least this should probably be split out as a separate change
> so it can be backported as a fix.

It should not be backported anywhere.

> > - diverge control and detect elements for mic;
> > - use GPIO mic detection on wm8903 devices;
