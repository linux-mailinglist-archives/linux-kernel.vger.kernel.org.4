Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57435E9143
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 08:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIYG1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 02:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIYG1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 02:27:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A953E770;
        Sat, 24 Sep 2022 23:27:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v186so3817348pfv.11;
        Sat, 24 Sep 2022 23:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=figvH0TFF8KUninkiSzsZB9ZDnznmKVoOGYr8J4oiTw=;
        b=EPQ46ZPafKCrXLBqT0pKN5ucNwF6hGnMi3WCJ9R5V1/B0KMsi+RsC6cIOREklJcrKe
         UCh8pcyhZFFrTVhZMfptRyxFCg6onXVq/yiC0X4nf28LryL9hjyGjY8/nUeOG1fVLvjn
         5ohmhouNB07lXF7NFUuRSxfSXe/s0BdzNsGf3CCzqAVNJQkj7214v/TKGwRAxpbyevoT
         T1ZeVRYs6QGo1LCw4knop2UhXVI1boXzHmIuesdH32z1Aln3RlypRKs7pVZIHPF86CKE
         sOLwl7WHgyyYoUsec4oxMMSS7Sx+xDSRbzOFQUbIvEZg2KkZxS/FYKpy0lTbT7PxLpPI
         M05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=figvH0TFF8KUninkiSzsZB9ZDnznmKVoOGYr8J4oiTw=;
        b=1QApttYwJlyFhj4ukFywsQpMC4kwXFfTadqd9SoPpDXq2KUlIthdHBdhQ6a8Bwkbsw
         dtq1Z+30h/BJpNPLPQktkEqFK9PNwmLbWk4vxkp57Sr3lt3gSNOq125RqiXMTFMJS1dg
         FTPBTXmFCqNpUHRdGiV38Q+uSLWxv51ZQPwpIim0a38W6Ng1MDJnM44u1HR34S86oXKq
         xCyW1t9qg+Q/vgufaUX/108VNRnHyxw1uktu8YuWxgPX6iILjwwKW96c+dLl1MhKO68z
         tf03cEOowRBBBoWE0MArehv7De4BFmPjR6L4l42AZX/kKG/an0klbEnCt9QS62/zZi9b
         TYww==
X-Gm-Message-State: ACrzQf28MLkvmjokffZD3I5ArvCh10r7vato+czbtRwTnMoCfIazg1ht
        LUaw4xSwIINIJrlUGACHUt0=
X-Google-Smtp-Source: AMsMyM6dR0K6JP5HP/gIn1nFWPsx5ZuJL5pSPAUigvAlQE+1kTa+/BtAxVe3/tIvUkpfa9IfAUbVEQ==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr17188516pfb.43.1664087226221;
        Sat, 24 Sep 2022 23:27:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:37c:3916:9a45:14cc])
        by smtp.gmail.com with ESMTPSA id bb11-20020a170902bc8b00b0016c57657977sm8725482plb.41.2022.09.24.23.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 23:27:05 -0700 (PDT)
Date:   Sat, 24 Sep 2022 23:27:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: qcom,pm8xxx-vib: convert to yaml
Message-ID: <Yy/0tuXJs+c40akh@google.com>
References: <20220917155705.2284-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917155705.2284-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 05:57:00PM +0200, Luca Weiss wrote:
> Convert the PM8xxx PMIC Vibrator bindings to dt-schema.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Applied, thank you.

-- 
Dmitry
