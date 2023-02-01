Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2368682D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjBAOZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:25:42 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FC72CFD9;
        Wed,  1 Feb 2023 06:25:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g9so10645495pfk.13;
        Wed, 01 Feb 2023 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LFqm80XL4N8A3cK/6unmCMbgVN/PxxBvxMYByXvFP9o=;
        b=a+U+cYav2jmubepWmK8UJC4ktmwnjK4y6W+kzH8gOdBaLvTjKgXy/Fe4iXMNr6DCEe
         J6ybCtdqJtBp5GxvQJ/5Kp5nckLo9e6DwazUH6yYC56+2rUqVfZnNRRe3YV4yLXh2kN1
         zYTEXJaArGFkYZIfyW2VdlEJyPshhHk2E8ZkfoUO+Ol/jqJA+9Tddb0+9xcUoKdVUGXI
         ooT8dqTyJn1T7TyX+bUjWFuvcuWS4m9NAUra1JAsd8tvh0PpuPTQX8Cz6HDmcIcBXHy9
         DbPGLJZ5/0JxAvoq+8frlHMj3KsYAPyMOFSmfkn4Q4TalINuzPQq45zyNDtOZ3Xnle6Y
         ehog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFqm80XL4N8A3cK/6unmCMbgVN/PxxBvxMYByXvFP9o=;
        b=Y0NidpG0yB9F6T1sH3ltIosWk2XuVBBa2T5xBGrE1/g1wvrtrfbJd3y6TmldRzZuPD
         V2wvZmZKL3u0vB26ywo4PGer4Zr3spfzPMHVl2wTztNwDzDq8J4BMKLaXpz5Ao/Uik21
         1yvo/sO5e97ZzndHYMwzOXmSvA5U0YA5K/riz6HvGxUMyk4dTBMnNX8NRxljHp03yKGy
         TPMlI01k03sJE33blCaYbKcO/zBfthGC5G850LcfcCqrAkplaiopvcMGGJQalzRtCxT/
         4YEnSGOAAm+jdpuRyWbRcE9tW61uYqB6M/KHeVBvDKY47avUVX6FTy5tlQOwxIxq5w6u
         zsvA==
X-Gm-Message-State: AO0yUKUF2MhD4IoHGFbymW2ZOoaBbnJOpFeza9a83TsgtR6thjLuh/fk
        TknZ+UZ3sBBlHVtXU1hL4xqOzhpFp2B+49ZCAA8=
X-Google-Smtp-Source: AK7set8yEwyxl0jqz9QWZh1c5+2nK4numLeYphTcsXV4WiwTUfOUAxOQYxtyP3fytZskebrJ8y1+5Cd7Obz8NkxhyyQ=
X-Received: by 2002:a05:6a00:1746:b0:593:cd0e:612c with SMTP id
 j6-20020a056a00174600b00593cd0e612cmr655229pfc.23.1675261540123; Wed, 01 Feb
 2023 06:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20230201120900.840725-1-markus.burri@mt.com>
In-Reply-To: <20230201120900.840725-1-markus.burri@mt.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 1 Feb 2023 11:25:26 -0300
Message-ID: <CAOMZO5AvSW9NY5Fbs-zjOZDvkrpoA5=3bkuR_q48fiATQ+GE9Q@mail.gmail.com>
Subject: Re: [PATCH v1] colibri.dtsi: Refactor ASoC driver name
To:     Markus Burri <markus.burri@mt.com>
Cc:     linux-kernel@vger.kernel.org, Manuel Traut <manuel.traut@mt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 9:09 AM Markus Burri <markus.burri@mt.com> wrote:
>
> From: Manuel Traut <manuel.traut@mt.com>
>
> ASoC driver names have a 15 character size limit:
> [   21.917463] imx-sgtl5000 sound: ASoC: driver name too long 'imx6dl-colibri-sgtl5000' -> 'imx6dl-colibri-'
>
> Use a name that fits.
>
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> Signed-off-by: Markus Burri <markus.burri@mt.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
