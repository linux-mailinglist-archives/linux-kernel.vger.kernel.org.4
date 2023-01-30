Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16CE680B33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbjA3Kqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjA3Kqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:46:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421231E33
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:46:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y1so10629822wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mI/eqdmLtpTRm3CiiBv1CsF9GzqTZ8zAMSJPlSWHw6A=;
        b=zblJ4ooAIMWAOG2z8HOQvhJ1wGk0wAogbJRSJ9CEea3zhJU64pTcw0DJFKKOkVL9BT
         Fx97l6Aa/3PswNP4hYxh4A9qYE1GQnuAAGHLuAgYl09vtcQPCnCQKdsxltRAPjyuNE/4
         Zk40Sb5FwwNbjxw7vB8FfFMzFKFV+xV5pQdfKTxrZLk2HyJXWOu+LASd1Lnf0X34dXHR
         vw+TcA1t65dhotD9YIPSe5ubIBr47Sb26nZMpJjssFPNXA+PLDX4wKkIIG9QjEOyGMBv
         FPHhXem44uZCvi0HR1O9GEvs6W4bLIiUd9RcJ8UIN0BsFAx90kTaF0W83UigGzWpFREV
         rWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI/eqdmLtpTRm3CiiBv1CsF9GzqTZ8zAMSJPlSWHw6A=;
        b=tAc1J8D+w2Zn/EoVOYxvgzKoC4o2w2F9YdCamOZpBdSXhnHwlGTN2yU8rfrrapDxFc
         4XxSQuORBiHwnXvtgC64qriswznDkNw4Ud1ApwZvPEL2atZnDqP7MlHCXF1qHHT8OXeG
         MqYfAqKzktaR6wrj1CWdp59UT8+oaekbmmTZe8zR2VgUYos3MzkYgWTzxz6uUQN6BVMP
         Vt0S3SdCtX+VsgD5d449/M4hLjv2rP9xRNK1IV9dZs5t5feHHJ4aCEAu7TOSBYw/MLs4
         J+UTP2tJTw6HgzpmWGMSgOMpqjFQU4kj2M7fLSSwHKNMrJf2LEbfsY9GaCQsKBtwbLdV
         urng==
X-Gm-Message-State: AFqh2kq8yJXVo30rlMhkKo8W78uLwQzGPctpyElEL2GnXmcCjnzLkknP
        E3c+3n5MKQtvT4w6DrKhaNRrBg==
X-Google-Smtp-Source: AMrXdXugqBoUB2xDTDq/4ERLbixH7Siy6ILXLzBtUGoLH5aRm9+ClxjifdpY5DPp384oDXQlOvdTuw==
X-Received: by 2002:adf:f0c1:0:b0:2bc:67d:c018 with SMTP id x1-20020adff0c1000000b002bc067dc018mr42851833wro.48.1675075598090;
        Mon, 30 Jan 2023 02:46:38 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002bfae1398bbsm11707320wro.42.2023.01.30.02.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:46:37 -0800 (PST)
Date:   Mon, 30 Jan 2023 12:46:36 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Fix regulators node names
Message-ID: <Y9egDJtDrNVpyfsm@linaro.org>
References: <20230127130106.1136226-1-abel.vesa@linaro.org>
 <7428b6d9-1653-4a4a-8e12-bc7ededef8a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7428b6d9-1653-4a4a-8e12-bc7ededef8a0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-27 16:33:31, Krzysztof Kozlowski wrote:
> On 27/01/2023 14:01, Abel Vesa wrote:
> > Bindings check fails as the schema expects the regulator node names to
> > have the suffix -regulators, so use the name and the id of the pmic to
> > compile the node name instead.
> > 
> > Fixes: 71342fb91eae ("arm64: dts: qcom: Add base SM8550 MTP dts")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> No, the original code is what we requested.
> 
> You are making it now incorrect (although bindings need to catch up).
> 
> See:
> https://lore.kernel.org/linux-arm-msm/9e805614-8d21-4f8b-1b31-790686c95aa5@linaro.org/T/#t

OK, fair point. Ignore this patch then.

> 
> Best regards,
> Krzysztof
> 
