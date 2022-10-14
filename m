Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3513E5FECD7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJNLB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJNLBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:01:51 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837071C8817;
        Fri, 14 Oct 2022 04:01:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so1627166otu.7;
        Fri, 14 Oct 2022 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DONsXOajuWuNYaaxPbQGe5zavVc6bwX+5tdOUk2Y3rU=;
        b=kFNbDjIbvcgJ0w32EltVcIqDlqZraEEleXeCjnTJZI8RaYN5NgDXAc4YjQX6IWH/mc
         DwyoqzCG5l3Ej7T0m77TmbgioXMp/GHUZcHW5Wnm4O+ApITXjMznkq4ZfApjlafkueM/
         sWmdqlBbi9FZI4qWeOxX9AFcMCUbyrMPNmakoYwetR62rSoMLu/WHm9sY+JrKtruFcli
         og3w3VzatsZodWgFKrnZqPAN2HSA/KtrZdSrQtgDUXoG/5GzFIMJqhJlMY1un1HYgTHI
         UnYRTUOFaqRQJ9IU/Ou8+9mq7ra3DXC8Zbu6CO+8BXO3FbZY/qaJkr1nIVPisUVWV+lu
         skNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DONsXOajuWuNYaaxPbQGe5zavVc6bwX+5tdOUk2Y3rU=;
        b=POrtYfCFcVe2/QDPKT4LeSatzBagjaS6Lo7BjDbDA0MdqXf6z9dcLNgj5uxYbHYOQ3
         G5ZNKIM89xozYKEFfIq8qOgaRuSd3TVC2w5lWp+nZSMnNKQl1qJl9c5XZiD8yNB2LBEo
         ca67+0MkAbDh8BWRZMl6AM3/strgsidWOF5nr8bTuAdL2cUet4MESb04L+StTYxgya5A
         b89HFJJGD4E6dZfWW58qKYGkK540L7sBGGaFyTQBxzg/lUXhmZFNt/oTFp312jlF7nct
         mr01ItmRWbe0BO8qHAQcrNcIij7/lJYlbIl3F/vcZoR69C+QUfp3p55ZqNX7ujFeetYn
         PzCw==
X-Gm-Message-State: ACrzQf0PrQVsjeWldtyr0FL7ThiidZJkpHarcoMR89dAMnx0g8z4Z0lB
        sBvZ8UsgQOlkiak3n4qZVPAefd8Hz5K2+jhBMIHGjMBr
X-Google-Smtp-Source: AMsMyM4dj+1+gSfLxZXFn/QYJvfXngcPJrn+7yN5csS16ILOPJa2WsmXeXyfhOmla5Lv1Jri/eTYyeonCQXpJOhD5Dk=
X-Received: by 2002:a9d:7204:0:b0:65e:5e5:310d with SMTP id
 u4-20020a9d7204000000b0065e05e5310dmr2159238otj.214.1665745309901; Fri, 14
 Oct 2022 04:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221012185411.1282838-1-dsankouski@gmail.com>
 <20221012185411.1282838-2-dsankouski@gmail.com> <99652775-8921-9d4a-193e-20d1487e6759@linaro.org>
In-Reply-To: <99652775-8921-9d4a-193e-20d1487e6759@linaro.org>
From:   Dzmitry Sankouski <dsankouski@gmail.com>
Date:   Fri, 14 Oct 2022 14:01:39 +0300
Message-ID: <CABTCjFDDEhNo0OVk+87kU93xwvXNR3tMuinfLXzZ6PeyweCpag@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: add samsung,starqltechn board
 based on sdm845 chip
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=87=D1=82, 13 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 16:43, Krzysztof K=
ozlowski
<krzysztof.kozlowski@linaro.org>:
>
> On 12/10/2022 14:54, Dzmitry Sankouski wrote:
> > Add samsung,starqltechn board (Samsung Galaxy S9) binding.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> > Changes for v2,v3: none
>
> Where is v2 and v3 of this?
I've been told it's easier for maintainers to resend all patch series,
even if only 1 patch from the series requires change. So I decided to
keep versions equal in all patches, to clearly indicate those patches
are from the same series. Please, correct me if I'm wrong.
>
> Best regards,
> Krzysztof
>
