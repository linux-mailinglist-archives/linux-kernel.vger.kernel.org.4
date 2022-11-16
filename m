Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59762C4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiKPQh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiKPQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:37:04 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BBC56542
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:31:01 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h24so11001865qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ApymBN4HCJe4qPGiaFQtDv5unh6AiatY7RGDCxWHUDg=;
        b=FrERdPZcuqjxQfZTlaYc0UDu4E5e6Q3qAG6L95OXLAXP79g/xalUGw/BhXBlOyqKBv
         jbNldlmaM5IOFfRm952+FVbMV6yJqK3Wy5jMZJYvdnSzxGca5E0MfuBCmlaADJeIQT8o
         i6ORG4y5fM5oPshbLC0l16ml5f5/HLLGBiyPje9CRyTcv0B5NO4wNQ51WxAM/VDxT2RT
         OXRVEx5VTflX13cxwXkjZYVLs0+LN/Tg5/hFbKY3jNMOhwrLSmpGYnfxGv3qSSKb3hW+
         6yA/9Q6rfLf+L1b4kTlP/k2RmiLizj/LM/TM4XlSt6UrXq8WODQWl2HzUVYM/ZK4AWHx
         CUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApymBN4HCJe4qPGiaFQtDv5unh6AiatY7RGDCxWHUDg=;
        b=GcdN9g3Thccg/mHXU3rMl68WuFANG3iPJQ6p0hB6nxG8BorLqPM+0/bjtraiyxlQih
         cOSbzaLEJ39q89gar0STbzCIRLIdZKp/ATw3V/0aeBK/6+RVfHYclXDTRfwqEci7W9OR
         1t4Ha2SVugGbb5LBKVMoWG8jC+xDR2P7PXHRulULBsevFD4Xy7rkziu4zrYUwThNck7L
         BVjvjO+BzS8lmQkZK2JT8rZCMGO5JZ6qbLkIczgyFIaSzOAqazI3UIhpAg5ivugGGRVp
         8cy0q38kfiy5t+snlOjN/yRSgv8qRnHIRZ9V5O4W2n7U1GqOzXRfXWG7cNDQE8w/S3mk
         WS5g==
X-Gm-Message-State: ANoB5pnov2ZAVG2AFxGNvXKoBBy+v9gyc8WAvAHiY0wIRZm3Klmc8P92
        sKhAHZyu8Alf1pE1NieFK9ysD3KaYKgQMVDFHpEOotX2OLhsaxdu
X-Google-Smtp-Source: AA0mqf7nZU1tzxNLlm9U6r0LUkMRNu1wpaM0W4L4pVP+0ls6sXTlGSEFegzPrvVwLv9bhlPQ+5bo0ytBD1d5XWy44Y4=
X-Received: by 2002:ac8:7303:0:b0:3a5:50fa:1a32 with SMTP id
 x3-20020ac87303000000b003a550fa1a32mr21752240qto.11.1668616260181; Wed, 16
 Nov 2022 08:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20221116154935.163810-1-krzysztof.kozlowski@linaro.org> <92993d1d-e7b0-199c-5652-5158988a65b9@linaro.org>
In-Reply-To: <92993d1d-e7b0-199c-5652-5158988a65b9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Wed, 16 Nov 2022 17:30:49 +0100
Message-ID: <CAGE=qrpAUcGwS5EQgMA9oA0c56=1C+2X5TjyyEFrf4xd5r7k+Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: use defines for RPMh power domains
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 at 16:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> On 16/11/2022 16:49, Krzysztof Kozlowski wrote:
> > Use defines for RPMh power domains instead of hard-coding numbers.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> I sent exactly the same patch yesterday.

Then the same as me I think you miss remoteproc@4080000. :)
