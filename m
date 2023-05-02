Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB526F4929
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjEBRdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjEBRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:33:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FDA10CA;
        Tue,  2 May 2023 10:33:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so4673660b3a.2;
        Tue, 02 May 2023 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683048814; x=1685640814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/EMaROrI2i9KpLF638deVHA9SzhqcPHiPbIMxa+oqCs=;
        b=TtfKjYFOngIpcabTXf4b3h5P92FouuwwzoU0MdOrVV9ICdP5I7cE04v128VkMD/gBR
         1knChnz4/btHW9LVn3hmew0vHfTkgE3isnkZVyoowYcEdke6TEHaG2opUeaTzYTsMxvo
         cjhvGGbG6INE78mcPmtQNZCakmZvXC54URqYPESN4i3sfvbJZxVIplW1cFy5hOQ9WEQo
         mXtTJoFK1T4WbsTKiti2PYkAhFg18Mi8zCppUQhTqbvf5TvLg7SO93MxdRK3JypCa12K
         p+8+pNKQYAQ+8rqxXOZ8PXmhG13DCVxNFUf9jup6MWrp0BuEI++E1isyjlZwTBIZ/uyn
         oRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683048814; x=1685640814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EMaROrI2i9KpLF638deVHA9SzhqcPHiPbIMxa+oqCs=;
        b=OR9fO3esUuTWgr5jAoseVFS1G3uZhqj4Hv6mhgkCPLwA4PDgpE3dfbwn3f/ND7YU7N
         Ru86pmhtBOyuarRHKE3EhZnnjAnNymEqsIvDowS5fbo4S/zxm9k7ZU1qkS5NNDRcDlqP
         ymzNL+djyRbViGpzgE7DFxVqzZ41Od3ZNorFj0C6ZEvIZ03K4gwtj8iPbinf6Ax5K6Ha
         UQQXtxU73qAq31qoIqlupsyhj3kkDpLaJ2dVopffwZGM1jkHU3iBr6RFdmU6VD3lHcVy
         pK3jr5+lGT3XN8CeGgLltnyRIxV5HDSjYI2N0I95Z31HwmUmLtHFhyPtD1ixQW6ZiYTC
         uCZw==
X-Gm-Message-State: AC+VfDzz39abff2UFxv2kIYGkB4abt1UBSNssS0NTe//TcI6sQtYUTYb
        jAfZA+FML8YH50S5s0RZoEVG/pTdqJLS5cgxsVk=
X-Google-Smtp-Source: ACHHUZ68qqt9fL8QBUEzePOiQsVBewohCEhnx4pgxnWxwVJGIn4CLimeaidxqucP916AlMapZUM74VxBvFZQTP10ed4=
X-Received: by 2002:a05:6a21:3945:b0:ee:d553:5cee with SMTP id
 ac5-20020a056a21394500b000eed5535ceemr19675175pzc.16.1683048814212; Tue, 02
 May 2023 10:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230429193336.600629-1-robimarko@gmail.com> <8feae59c-b762-8cc8-7aa9-237ce4af5b1e@linaro.org>
 <CAOX2RU6wwvMLgScAgtqpOuSLeaULUAet4TtjQZkWK_uwwkr2Zw@mail.gmail.com> <4bfcbde3-c9e1-65a9-4494-3d9bb222a89f@linaro.org>
In-Reply-To: <4bfcbde3-c9e1-65a9-4494-3d9bb222a89f@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 2 May 2023 19:33:23 +0200
Message-ID: <CAOX2RU5qE-3_K+QMqkUQU5MO2P_nN5gpZVYG5JTUdxYf5oQ7SQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ5018 family
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Tue, 2 May 2023 at 11:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 1.05.2023 23:22, Robert Marko wrote:
> > On Mon, 1 May 2023 at 14:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 29.04.2023 21:33, Robert Marko wrote:
> >>> Add SOC IDs for the IPQ5018 family.
> >>>
> >>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>> ---
> >>>  include/dt-bindings/arm/qcom,ids.h | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> >>> index 802495b20276..c1283bad81e1 100644
> >>> --- a/include/dt-bindings/arm/qcom,ids.h
> >>> +++ b/include/dt-bindings/arm/qcom,ids.h
> >>> @@ -216,6 +216,9 @@
> >>>  #define QCOM_ID_SM8350                       439
> >>>  #define QCOM_ID_QCM2290                      441
> >>>  #define QCOM_ID_SM6115                       444
> >>> +#define QCOM_ID_IPQ5010                      446
> >>> +#define QCOM_ID_IPQ5018                      447
> >>> +#define QCOM_ID_IPQ5028                      448
> >>>  #define QCOM_ID_SC8280XP             449
> >>>  #define QCOM_ID_IPQ6005                      453
> >>>  #define QCOM_ID_QRB5165                      455
> >>> @@ -229,6 +232,9 @@
> >>>  #define QCOM_ID_SM8450_3             482
> >>>  #define QCOM_ID_SC7280                       487
> >>>  #define QCOM_ID_SC7180P                      495
> >>> +#define QCOM_ID_IPQ5000                      503
> >>
> >>> +#define QCOM_ID_IPQ0509                      504
> >>> +#define QCOM_ID_IPQ0518                      505
> >> Are you sure these names are in tact?
> >
> > Hi,
> > They should be correct, I am seeing them being used downstream
> > and in end products as well, IPQ0509 being one of those weird ones
> > that integrate 256MB of RAM on the die as well.
> Hmmm.. it's sketchy and weird-sounding, but also appealing in a way
>
> I got caught off-guard with the leading zeroes, but probably qcom
> just didn't want to mess with the IPQabcd scheme!

I would guess the same that they wanted to keep the naming scheme
intact, I also thought it was an error but then I found FCC images with
the IPQ0509 SoC being actually used.

Regards,
Robert
>
> Konrad
> >
> > Regards,
> > Robert
> >
> >>
> >> Konrad
> >>>  #define QCOM_ID_SM6375                       507
> >>>  #define QCOM_ID_IPQ9514                      510
> >>>  #define QCOM_ID_IPQ9550                      511
> >>> @@ -236,6 +242,7 @@
> >>>  #define QCOM_ID_IPQ9570                      513
> >>>  #define QCOM_ID_IPQ9574                      514
> >>>  #define QCOM_ID_SM8550                       519
> >>> +#define QCOM_ID_IPQ5016                      520
> >>>  #define QCOM_ID_IPQ9510                      521
> >>>  #define QCOM_ID_QRB4210                      523
> >>>  #define QCOM_ID_QRB2210                      524
> >>> @@ -243,6 +250,7 @@
> >>>  #define QCOM_ID_QRU1000                      539
> >>>  #define QCOM_ID_QDU1000                      545
> >>>  #define QCOM_ID_QDU1010                      587
> >>> +#define QCOM_ID_IPQ5019                      569
> >>>  #define QCOM_ID_QRU1032                      588
> >>>  #define QCOM_ID_QRU1052                      589
> >>>  #define QCOM_ID_QRU1062                      590
