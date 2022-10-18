Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD40D602971
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJRKhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJRKhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:37:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713672B632
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:37:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so13627090pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWwcbHxc4gNZkpX9lULBb97jbG0T6/PKCXFFwxy3BRo=;
        b=Q/VWQoheR0jWqMa+lig4NkopBmoRotDVaP9cGfl7W4DQXcbenSZTvnHlU8ec5aY5Cd
         jBcPRpEQBqqGzCmNQmhr1llswDmnoxy4Vj1PMy0QYDpv6AVlZC7OQXu0eAY4SQmNIhBh
         v8Ej7R1pjU4YXoKJWzA3RMe3ynKxYOBjVlE56Ebbg795HXfU1w9F137tWGRC+aqPzyV7
         iEehitdslfnyYbRf7oFhgqGOjtU2fml9JibMeOeuXxwWUeWifXf9VW8qJLdY9e5tN/5K
         P2Bs5z9LTvlwQw4z0p5reRgY8WmxLyLYIXQH45UFupvLtkdIxLDtAjzquUMDFa9ElfU9
         P30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWwcbHxc4gNZkpX9lULBb97jbG0T6/PKCXFFwxy3BRo=;
        b=voeHv5WgOsqWYHGhuyXRqFBhUjGowWi6wQZu4LP3fGYHjDcjYofLCowU+NN1ZIDmOB
         FrbFoNebEtdMxdiK1X7lYJENXxQFBQ/52bvIiWWEE44cExzm9k1qHvVmqJSZYrLQjHlk
         RHD3D0Ilee1RqcO5fyZu/UoQGKw50RzKmfOMtxU0ySBgawtqlVTyKYPS6qOSRxAb1tPB
         akenuyZqtcq4tNA6FoKXLt9U9c5CSWcXncB+DDmzckfcfPWEIPCgjxvxcCAYiBTU0lxT
         smeuM+LWP7HDoxabsREHxIKVxHO6XMav92NZvAza8ihzOS6lWRdVNftKYgO0SPpgwEWX
         m1pA==
X-Gm-Message-State: ACrzQf2R7KzW6DftIuYLhQzVlPwH+PXC4GfgtvZHGbxWAPjVsECec3/5
        A9rxkhQ9+Gsiu+mRMcSOWVWDmw==
X-Google-Smtp-Source: AMsMyM4Fyb5TgyL3VpXLmiFDY5cvDh03vJUy5fgOn3WKBILuMSVwtJ1mW+U1Wh6C6g7EfbpKaVxMzg==
X-Received: by 2002:a17:902:e750:b0:17f:71fa:d695 with SMTP id p16-20020a170902e75000b0017f71fad695mr2519699plf.105.1666089439919;
        Tue, 18 Oct 2022 03:37:19 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b0017ec1b1bf9fsm8523191plg.217.2022.10.18.03.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:37:19 -0700 (PDT)
Date:   Tue, 18 Oct 2022 16:07:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fabien.parent@linaro.org>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] cpufreq: qcom: fix memory leak in error path
Message-ID: <20221018103717.kjwmecadk6dknwxm@vireshk-i7>
References: <20221015130424.1923706-1-fabien.parent@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015130424.1923706-1-fabien.parent@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-22, 15:04, Fabien Parent wrote:
> If for some reason the speedbin length is incorrect, then there is a
> memory leak in the error path because we never free the speedbin buffer.
> This commit fixes the error path to always free the speedbin buffer.
> 
> Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
> Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
> ---
> 
> v2: Added missing "Fixes" tag
> 
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied all three. Thanks.

-- 
viresh
