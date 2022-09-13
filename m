Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC05B67F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiIMGcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIMGcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:32:45 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCAB13F71
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:32:43 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3450a7358baso127530997b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UoQ28Kix9CadreRi69EyX+ldkRLWeLo2Q5k9iACgE4I=;
        b=Y1Q89KwkYzAHSigQEYEXus5Ug+5BK8mK25+4i2lyKTage4SbMj2vPVOakyK3XRQqN0
         XZBpGa5DBuVgbQDPbkC5p+eJYTETxHEO5atUNthgQxJI+RT9uCb6f/1V/UGSElsu0oy6
         tbHdy7UsZtmSe3Af42ehQ186k1aFEEyrfJLfNkbTfMA0NJEkxakM3b8wPyj7wA/lE9Mu
         ijxt+n/xhxH2Kn4rh5RwiN2t+sR9/KysFNGXcU+DR0wCk+9WJYK05vat0/ouEQQ+rRnT
         iOfnP+L3T/tW0ctyKyydMPkkZYeSx8BbiLiWo2lIB94I7B0bMqLAzJqVz1GKxBGEnNmg
         T3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UoQ28Kix9CadreRi69EyX+ldkRLWeLo2Q5k9iACgE4I=;
        b=PIMIfq8mL9/8Z1U+WgEXI6xv1IaFiy2xpk6IBdE1Xs0gGN3vtRFk3XsELjykLnUx+o
         kh3MDMsqC1uPibY+o1wCVPZgY8OPxwPIFPO3TcS2EmbvPsGkAqeUUKzn8q+mAUVELZKd
         a89vULlggV62AklX+1awn8YLaXqZcUYYIcEMfB1tZZAH6CVbI5sA5HIzyuY8FHgsCEw1
         g5v0fzIi1FBuW4gvvzODxdOxHveRVbtcrvs9/uPKnxhIC1ee/pVgjI2D1Lkb4LJ1CKnH
         28R26TG5uaN7yaJP1LT8idQmppJ3hbhMaphibf0Mo6Tk7dkpHjQXAvUWQZR0vwl1/J3T
         bxCA==
X-Gm-Message-State: ACgBeo1zmsCZFKVYjsmdRSwM6tN8rFSnJ8EEI+F+n8o91TWuA7ZA+7S1
        mMKmba5kH3Di3rCgow4yZA4aMtpR18Jc7bmUW5I=
X-Google-Smtp-Source: AA6agR7vJdcYJ1/d5RVqxccuCSAUIxaq24XEnGW9TXhYpfRs4skcLkMSg0t33aDJzr021LbOQwU+u1u2i7YknowD2Yw=
X-Received: by 2002:a0d:df93:0:b0:348:f7a9:97db with SMTP id
 i141-20020a0ddf93000000b00348f7a997dbmr12350017ywe.268.1663050763139; Mon, 12
 Sep 2022 23:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220912214535.929116-1-nhuck@google.com>
In-Reply-To: <20220912214535.929116-1-nhuck@google.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Tue, 13 Sep 2022 08:32:32 +0200
Message-ID: <CA+sZ8B8RStBhofQ0=vvzH5FeQ66fj90DdCj9EQSaVErbVPLi7g@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: Fix return type of rtw_xmit_entry
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Ivan Safonov <insafonov@gmail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:45 PM Nathan Huckleberry <nhuck@google.com> wrote:
>
> The ndo_start_xmit field in net_device_ops is expected to be of type
> netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
>
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
>
> The return type of rtw_xmit_entry should be changed from int to
> netdev_tx_t.
>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

I am unable to apply your patch. I think because of this:
3e0a6c4414ac ("staging: r8188eu: remove os_dep/xmit_linux.c").

Can you update your git repo and resubmit?

Best regards,
Nam
