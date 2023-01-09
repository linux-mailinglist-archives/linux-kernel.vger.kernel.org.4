Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE662662302
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbjAIKTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbjAIKSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:18:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62362192AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:17:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so8615752wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3sOlEh1WygNZ9VgKuMT1nyO+XwDijk/5Tq8drEBoAk=;
        b=MFsTsxkaZ1UIaBLLEtyfh6RzAoMnlZIPWc2WNX24+naYBw+7xbHepz8S0WIRSWvs1Q
         hFGnYAlOMC9nu7Dq8xrrL4T2gUcRQt0bt83THvKOHhC0DVH6vvLjMs2MAcBw909AJiRS
         qMCN+qyQ6vUnwNU3U1UBVFGfJPTey2337q681pGCUpaC6Inskp054voPJpa9s6Qla3o6
         4w8mPTO5r+A4aMr+Db/R86sLp8lJq3fNYQbV3tiDS9C6kYt5zGgwblJo3f2/zIo6mrC5
         hJy64lNfExzMNmb+xszSBOLj+2gPktUJZXWKdc9QtM36BOQLMe7I3ZOxN8IY0tak096M
         18+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3sOlEh1WygNZ9VgKuMT1nyO+XwDijk/5Tq8drEBoAk=;
        b=vc/wiZqF8MTozD/Z0Xgspvgccy7kjQSQk31F+c7pko69GGaP+1MJTEsAggKt5bdbCQ
         oO5yc6isaAxJrPkiJRdPEODaNtX5exhtXZCfd3VvtnIPLas6SFf+tN4Qj8ea+3Hxq17q
         VWW1QBXda2Ck72fXPY3+IsejIOmire78ADeF8A2AKmXh2LTWnRZOhWmwL5EiiB5WB9qu
         HI1GIJ10wHFKSuXjsEqIQXLp2cuIyBn6Xii1fKdGwrl6EcIpqXfev394DC1LzByUSHbI
         j1Fjw5QSpT0UtbquWcB8I2gS0Ue+6jIGKfu3u7sdXpxj8w/0jI3L5pwIa34ye75wS2CU
         l4SQ==
X-Gm-Message-State: AFqh2kqxcD3oGVbP7iMvJcqUrU06OrnDCrxmOQYxRkxzwEhtJnYP4hC0
        uJVYit9P06v8PuuYxXlLg4fEbw==
X-Google-Smtp-Source: AMrXdXsqG2Eq26xzrbOkrTahh2oj+h0pui/EEw14ypYWszSZeNLm98tUrOlKsZ9KmBa27ZomvzRi5A==
X-Received: by 2002:a05:600c:a4d:b0:3cf:6e78:e2ca with SMTP id c13-20020a05600c0a4d00b003cf6e78e2camr49520896wmq.5.1673259444880;
        Mon, 09 Jan 2023 02:17:24 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b003d1de805de5sm12213442wmb.16.2023.01.09.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:17:24 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:17:22 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/4] backlight: ipaq_micro: Use backlight helper
Message-ID: <Y7vpsigT9EUz9FWn@aspen.lan>
References: <20230106164856.1453819-4-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106164856.1453819-4-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:54PM +0100, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

For the tools:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


D.
