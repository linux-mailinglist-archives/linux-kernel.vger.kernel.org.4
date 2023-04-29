Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A996F2199
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347147AbjD2A36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347032AbjD2A34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:29:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB93AB6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:29:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f40b891420so347910f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682728193; x=1685320193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiCF4OnwxjmLf3NeMqtDogKkBQycEZ1KKUyCMRH1bAQ=;
        b=Yyz+/IjOdagk+9PlvWN88UlEn1X1/vrQb3GBPQTuvSIot2K9jCdkdOnEE7Ay8UJoqb
         b4BWOAlwfhAM33VX0MvIBFSfgC0R2sPyIS3gVm8zfuPLIJeTfA01+eoTvIyChSYKa2Zr
         mrWiPyTC75fEVUNSs5S9idlkaKiG6XbqXUmlSJr/2oZKijf94dW+g/A1yffpRKSGGlv0
         eVd2epif3fsb+okfFBjTSdbdDD268zSkmf907eq9Pf2gyaprgQtyqQZR7M0Wazx72ZXE
         7025XgUWg/8YAXFMPn+eg8xV2aI5BtKJXE38jkd9Vetdx/RmiSjm0SsVPX2WIFIWuN3Z
         l4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682728193; x=1685320193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiCF4OnwxjmLf3NeMqtDogKkBQycEZ1KKUyCMRH1bAQ=;
        b=jvgyXd5UAV/msOm64ZwQS3KU5+Hlek4bmm3RrhYIPWovTI1EOJkha6MgujoqLS+td7
         J3kKsXN3VDL5FGR1CMNvfGbOrCKs076Z4Wr/zd+Gep9JdA64prfUXG9N5ov08svREhOb
         /7yYbqsLau3xe1HUNwQss09EsmorTL+V6VnW9XiIvaMzTdPI9Z60Xa6Ctn5wSEsKVzNj
         0M6qbYV8vudDEe9iN2OIxevz3ESJ1A8DuDUt/PmHhSksMmtseQEhVgXP8d9asMGUTn2X
         xATvC771VfpZF6jPdXqJN4aaDpa8mEWX1nmzLH/BtEKIZNVyhwxcxsstPWOGxVqPbim2
         XC5g==
X-Gm-Message-State: AC+VfDyspklkGmtxcw1lBFPSaQ0s4QgqRVfj0WtnWRyDFIAGN8L8ytrq
        q0qcykw+B35lvQ+0EXpaxFcWSw==
X-Google-Smtp-Source: ACHHUZ6tC3OMzhsDU9xiKI+1LEOh6A9DsBYjRaeBqbDzEVQj9IGhTX6w7rY7JBvYO9jf4eb3gjKujQ==
X-Received: by 2002:a5d:5222:0:b0:2cf:f01f:ed89 with SMTP id i2-20020a5d5222000000b002cff01fed89mr5766079wra.24.1682728193374;
        Fri, 28 Apr 2023 17:29:53 -0700 (PDT)
Received: from [10.6.147.212] ([212.140.138.218])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d4dc8000000b002f9e04459desm22133933wru.109.2023.04.28.17.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 17:29:52 -0700 (PDT)
Message-ID: <5089956f-a5ee-5b18-ce83-edce6999d583@linaro.org>
Date:   Sat, 29 Apr 2023 03:29:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/7] add DSC 1.2 dpu supports
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 02:45, Kuogee Hsieh wrote:
> This series adds the DPU side changes to support DSC 1.2 encoder. This
> was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
> The DSI and DP parts will be pushed later on top of this change.
> This seriel is rebase on [1], [2] and catalog fixes from [3].
> 
> [1]: https://patchwork.freedesktop.org/series/116851/
> [2]: https://patchwork.freedesktop.org/series/116615/
> [3]: https://patchwork.freedesktop.org/series/112332/

Changelogs? There must be one, either in the cover letter or in the 
patch commit messages (following the DRM subsystem custom).

-- 
With best wishes
Dmitry

