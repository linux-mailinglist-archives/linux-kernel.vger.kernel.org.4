Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6654F7044E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjEPFwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEPFwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:52:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4932540E4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 22:52:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6438d95f447so9511347b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684216366; x=1686808366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZccG4uIRo7CsNZMhsJ6CCNSTyo4mWHxGlBVFG2V88w=;
        b=VUCSQHNQ7T7rZJufnY+Z2j0d1XmZJ2oZ32+ajJ1XPcOqeByQccmeoxCBDZHgTjsTZy
         X5cIMmzph8VZNxg/DrpKEEyWLdnhJsQT6RmaGPzudIFROFh4skDwR26yDXIY3QDgE0pp
         duXiiD/AOdTwuksF+glpR/daurdXaZoUro0d3ZcIyU5AXq5XYGXl+KLE2oIPcY2YQ11w
         Ay77u+Hh8wmgLXXFhB2ksVmYUTOVImNYAARmNaSdfKzdTIvJUlxtKlyJwqDfe4aHoZyg
         juJSr2UkVRdMum1DToDnE5BsgdtCH8+txFU57z58pN7SNvExqLNcdFfpn+iuVtDj0t8K
         V0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684216366; x=1686808366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZccG4uIRo7CsNZMhsJ6CCNSTyo4mWHxGlBVFG2V88w=;
        b=BIrt82JVqL7Gvtvk6Vew4K/wh72bhebCKllU+e9P+Wn3fc3ttIRXBLU8DOnuwu5XrE
         XK+4CpjypmHPwson1HQyJGEJ6i8HpuRf1xNqSq1HlbyAOhucUgVdFsc2qtYPq12bbsek
         oJ/WbvunIsYUsF945a4X+g4jx/kPZ7Da2UbCieJtEH/ulDUkYakRF09KEssmjehj/lHo
         AfPI4CB0ArzfTEkEhP152d4aaT6nbewQcqHkj7gwZzLZ7IG76lk0tIODi5pzOZ0Gfbm0
         GqtuQkcriLl7J2wwdF+1Mt2qgxtyL3Fahdrds4luWsQ2bMWpLcSLvfSCPns8YWqHh5ra
         J98g==
X-Gm-Message-State: AC+VfDz+DLbK0kxRZDGZwhQ04aCpGpy5yJrIml9u2ixP28VOhPTQEzOu
        M5hmzNh4yxB6rvmVyyKIjIKOow==
X-Google-Smtp-Source: ACHHUZ4g6s0Ec9Wt1DikFOpmCRplYseZbig/nabKGOh1A0zHibPlOtpL0Om/DkFQC3KoYIXBZ0O+Xw==
X-Received: by 2002:a05:6a00:9a7:b0:638:7c22:6fd with SMTP id u39-20020a056a0009a700b006387c2206fdmr52364827pfg.1.1684216365743;
        Mon, 15 May 2023 22:52:45 -0700 (PDT)
Received: from localhost ([122.172.82.60])
        by smtp.gmail.com with ESMTPSA id j22-20020aa78016000000b0063b87f47062sm12373415pfi.127.2023.05.15.22.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 22:52:44 -0700 (PDT)
Date:   Tue, 16 May 2023 11:22:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     ray.huang@amd.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com
Subject: Re: [PATCH v3 2/2] cpufreq: Warn if fast_switch is not set
Message-ID: <20230516055242.yfbf2jhdhz7uuwtx@vireshk-i7>
References: <20230515113404.4259-1-wyes.karny@amd.com>
 <20230515113404.4259-3-wyes.karny@amd.com>
 <20230516011001.epa4xlvbiimu6ai3@vireshk-i7>
 <ZGMZUhWCU18Wn/47@BLR-5CG13462PL.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGMZUhWCU18Wn/47@BLR-5CG13462PL.amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-05-23, 11:19, Wyes Karny wrote:
> Sure, I'll do that. But one caution if we return failure, the drivers which
> has the above conditions won't load.

They shouldn't :)

-- 
viresh
