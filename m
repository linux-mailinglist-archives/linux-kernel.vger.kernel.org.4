Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9396E6C57
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjDRSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjDRSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:44:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4E93D7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:44:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso2123015b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681843480; x=1684435480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h0Ye4YzfuTyVJhc3KWw9FhoYxdOlS0tgXzf1S8Y6JY=;
        b=hwr4DfGlA0LVFdLW955zFp7mTAHAENcrEHsi6IwXYBYqhH5DmANidRKqkGi/i4e6Z5
         mQpOvJYJup+h6qXClSv+sncQdafdVcwTQH8HqTiwZ63gZOrFVOLgP2iv6DSHeFNcmhZf
         J4ItVEF7/OPio/GHJS3thEifa2RDAmJKdin63BzsME6o7Xaqk0Bwr68waO+IGxSxPDEZ
         OHPWWAUT443n7YLma2AAKHk5DVl8I6/202vfBbucgg26uvKcsqhBNe38ChlO0N2UPRFW
         q8fH0Tkjoiqu5yPrfp2IAg2a3uVELg4ZJnRh5+XYvndU40DEQEQrE5lehVLU0p+VOp32
         5mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681843480; x=1684435480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/h0Ye4YzfuTyVJhc3KWw9FhoYxdOlS0tgXzf1S8Y6JY=;
        b=EiUgL4M2yiVlBN964FkABH8a+a699DOxOyfnE5Er4gdTdwdu/iv3aF6XRwxiHJOguT
         F70Y6A0fZMhYt3kQOlnccqlvfzKYkJCNI7x2TzlhM+RYyGUJZRx0r257rLxujcIA4WXJ
         06nvhomS+yVPfgVK2SvXclad+iiJrOI9WzGg2V/48UJ1MACWmQcQKVLEiQN1i81XrTrc
         /lHf4vwNzN5lHOWeVjm8eb3Vf0+kss5hq18XelCtq9/PpFlDS6WskV8YAG47eRjKV9aU
         sQwg+giRKtwIVtRyvm4h3uVmYSP1QOmA+FXthyrRcUJaguh8KFgjMrzpyZq9YvpWV5fj
         hxpw==
X-Gm-Message-State: AAQBX9cDAyMIAzIgoHU2Z4cHwo2/Lz1FVPnjlagRWm8qw3UprAn9U1SP
        RVZr0skVd8xaoY3uWl8hp5sNSgEAntqLqHzXRC4Z1Q==
X-Google-Smtp-Source: AKy350YmXyurrrdutX3TxFOkZkZRSQwtF8YI9jpYLN30ZWVx/yRDmwS1d5gzSB8AfjG6MGZpUIMnfzIKD84qWtJarOY=
X-Received: by 2002:a17:902:eccf:b0:1a6:9671:253e with SMTP id
 a15-20020a170902eccf00b001a69671253emr3279751plh.47.1681843479724; Tue, 18
 Apr 2023 11:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230418-pruss-clk-cb-v1-1-549a7e7febe4@kernel.org>
In-Reply-To: <20230418-pruss-clk-cb-v1-1-549a7e7febe4@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Apr 2023 11:44:28 -0700
Message-ID: <CAKwvOdnj7rNeh0YeX2NPcbkoJBnRwXb9Dt0SF9mHaMKYVLjCjw@mail.gmail.com>
Subject: Re: [PATCH] soc: ti: pruss: Avoid cast to incompatible function type
To:     Simon Horman <horms@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 4:41=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> Rather than casting clk_unregister_mux to an incompatible function
> type provide a trivial wrapper with the correct signature for the
> use-case.
>
> Reported by clang-16 with W=3D1:
>
>  drivers/soc/ti/pruss.c:158:38: error: cast from 'void (*)(struct clk *)'=
 to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wca=
st-function-type-strict]
>          ret =3D devm_add_action_or_reset(dev, (void(*)(void *))clk_unreg=
ister_mux,
>
> No functional change intended.
> Compile tested only.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Here's some more suspects to look at, if you have cycles:
drivers/base/devres.c:734:int __devm_add_action(struct device *dev,
void (*action)(void *), void *data, const char *name)
drivers/i2c/busses/i2c-mchp-pci1xxxx.c:1159: ret =3D
devm_add_action(dev, (void (*)(void *))pci1xxxx_i2c_shutdown, i2c);
drivers/soc/ti/pruss.c:96: ret =3D devm_add_action_or_reset(dev,
(void(*)(void *))clk_unregister_mux,
drivers/mmc/host/meson-mx-sdhc-mmc.c:791: ret =3D
devm_add_action_or_reset(dev, (void(*)(void *))mmc_free_host,
drivers/pci/controller/pcie-microchip-host.c:866:
devm_add_action_or_reset(dev, (void (*) (void
*))clk_disable_unprepare,

>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/soc/ti/pruss.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index 6882c86b3ce5..e68441bd7b30 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -38,6 +38,11 @@ static void pruss_of_free_clk_provider(void *data)
>         of_node_put(clk_mux_np);
>  }
>
> +static void pruss_clk_unregister_mux(void *data)
> +{
> +       clk_unregister_mux(data);
> +}
> +
>  static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
>                                char *mux_name, struct device_node *clks_n=
p)
>  {
> @@ -93,8 +98,7 @@ static int pruss_clk_mux_setup(struct pruss *pruss, str=
uct clk *clk_mux,
>                 goto put_clk_mux_np;
>         }
>
> -       ret =3D devm_add_action_or_reset(dev, (void(*)(void *))clk_unregi=
ster_mux,
> -                                      clk_mux);
> +       ret =3D devm_add_action_or_reset(dev, pruss_clk_unregister_mux, c=
lk_mux);
>         if (ret) {
>                 dev_err(dev, "failed to add clkmux unregister action %d",=
 ret);
>                 goto put_clk_mux_np;
>


--=20
Thanks,
~Nick Desaulniers
