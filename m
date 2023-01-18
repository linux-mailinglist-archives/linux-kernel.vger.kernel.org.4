Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D16671E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjARNuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjARNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:50:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C835CCE899;
        Wed, 18 Jan 2023 05:19:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A361B81D0B;
        Wed, 18 Jan 2023 13:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EE5C433D2;
        Wed, 18 Jan 2023 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674047986;
        bh=ePgAPHOhTVOksHn0s2syMgYNYHXIHMPRSxnZp4wJ/38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ia5UQJcongu0X+ElLOSAtjQ1h1Z4S8tC04z/rG10+8rBeyzSAG+V4BT6/5C0IPSe5
         AaeNqgUaa0LWvfxRH4MDg7CxNPUrjB5RvCqiKJzFlFnqtOwORYtqxveFLmv0JBcIfd
         /JJ3AgX+e0Rq8Pz2ob9MAnVqKiOg4UDw6YzMVaX0f500Dl+dowhGo+bL1FjyU6k2bH
         w6mVhx6OWVFU7z++pOiffB/9KSR20DlnpNNgHA3yrmPzA8LkznjS7LEA6ntUDAWHwt
         aBUg/YgXl7oVEWkCLy1QhaZMm8nANXwJrm0xJB3gvXRFQuU8pyXMS4Q8tyx0Qj5HZU
         7Wx4HcKaK8Hpg==
Received: by mail-vs1-f46.google.com with SMTP id 3so35661872vsq.7;
        Wed, 18 Jan 2023 05:19:46 -0800 (PST)
X-Gm-Message-State: AFqh2kruyZEcAs4t3TqgJb7oKevd6nx8SEzuA22k0xahyXzBhA71Zo8X
        zKdhjAkorzbxy+LeukfbiLd12pNf8RLTe7Ipwg==
X-Google-Smtp-Source: AMrXdXux9aAlM451KGBma1Qs2rJpTOL4EbQDljgAz6sNK/elrsA2uBmlRu/x//wMYoC5wIXCvkWkR51ZCIzD8PoAZoA=
X-Received: by 2002:a67:f506:0:b0:3d3:c767:4570 with SMTP id
 u6-20020a67f506000000b003d3c7674570mr1026153vsn.85.1674047985721; Wed, 18 Jan
 2023 05:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20230113162214.117261-1-krzysztof.kozlowski@linaro.org>
 <20230113162214.117261-2-krzysztof.kozlowski@linaro.org> <20230117192724.GA3489389-robh@kernel.org>
 <331eed95-eaf7-5c5a-86c1-0ee7b5591b9a@linaro.org>
In-Reply-To: <331eed95-eaf7-5c5a-86c1-0ee7b5591b9a@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Jan 2023 07:19:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJUTFa24iZ2fovE_yJdBVcbkcUX8rBoPB12ptdAyxHW6g@mail.gmail.com>
Message-ID: <CAL_JsqJUTFa24iZ2fovE_yJdBVcbkcUX8rBoPB12ptdAyxHW6g@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: qcom,wcd934x: Describe slim-ifc-dev
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 5:25 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/01/2023 20:27, Rob Herring wrote:
> > On Fri, Jan 13, 2023 at 05:22:13PM +0100, Krzysztof Kozlowski wrote:
> >> The "slim-ifc-dev" property should not be just "true", because it allows
> >> any type.
> >
> > Yes, but it is common, so it should be in a common schema. Though
> > there's only one other binding using it (wcd9335.txt).
>
> This is still wcd9335 and wcd934x specific, not really common. Maybe
> next Qualcomm codec would also bring it so then we can define common
> schema for the codecs. But so far I think it is not really a common
> property.

By common, I only mean used by more than 1 binding. That's already the
case, there's just not a schema for the 2nd one. In any case, can
address that later.

Acked-by: Rob Herring <robh@kernel.org>
