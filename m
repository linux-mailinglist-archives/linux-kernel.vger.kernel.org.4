Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22760F2C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiJ0Ip0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiJ0IpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:45:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D937B1D7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:45:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m6so872916pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHK0d0+DTSltgpKGBcL7Bt7tyx09Lrl7MDMzO3t8/Gs=;
        b=E5A9cHvZuY9j4PwVDYHeC+xGme/yze2WmU/7immd2JuOOOTOZN9JRa46pBF5CmOczG
         NXDyNaMPQCYcs8/+/moMsAlUTeEZXQ05jaFd9zCGwIBz8oUEJJaqDCDyvwdo9Tl+1pQe
         AxN4idYfWS4xL5nUF0JkafbSxZiqJB7hjEXeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHK0d0+DTSltgpKGBcL7Bt7tyx09Lrl7MDMzO3t8/Gs=;
        b=z6l+oyzXmb9FyPIyq4HV9Y5bdTkFS8kH1YjkvsQXy4yUOBBIz5sEDCK5P/7Gc/F1E4
         qL/6bohsRxPGt1jrkO8Ddre3gdbZBeFlkDS8d4qzRbY+cMNJOevnekLWMrsLXy/txS5o
         vLFQphgI8pyfh4sqUS57rmO4SsqVjPITszVNvfcyItWliDX7QO7gaED6gzxZQbN/A0FK
         oB8qucijw21VRM1y5gtPmjiOv8E+PhVznTnvyqjkK3EK5v2NNhVcme4iw7lzRxD9Kyh3
         WP/jV9c6QFh6SeJ/jpEsyS7xp7yaW1PtFPLeARf2bv1gds/73pPB3we+ytKJVawHELod
         EMew==
X-Gm-Message-State: ACrzQf1d58nlN4Smw/VTWLs3z9cMssJiOiVQ8ZjN9QQuxjrQGt5/TX/3
        8gn3eb1LMHlc34RasGfZRpr5nQ==
X-Google-Smtp-Source: AMsMyM4x555siUw6CJKl4TiCxEW9qvQS89XWebHZTqYHXDPe8Tbe2cAKHdaOh/ZoZVDR8+tsmM9QXg==
X-Received: by 2002:a05:6a00:13aa:b0:56b:c782:107f with SMTP id t42-20020a056a0013aa00b0056bc782107fmr20614262pfg.43.1666860320124;
        Thu, 27 Oct 2022 01:45:20 -0700 (PDT)
Received: from ?IPV6:2401:fa00:8f:203:86f1:106e:aa39:419c? ([2401:fa00:8f:203:86f1:106e:aa39:419c])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b0017f61576dbesm646736plh.304.2022.10.27.01.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 01:45:19 -0700 (PDT)
Message-ID: <17d808c5-c1a2-680d-5841-e0d07b4a8da6@chromium.org>
Date:   Thu, 27 Oct 2022 17:45:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 0/7] [RESEND] media: uvcvideo: Implement granular power
 management
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
References: <20220920-resend-powersave-v3-0-c47856d8757e@chromium.org>
From:   Max Staudt <mstaudt@chromium.org>
In-Reply-To: <20220920-resend-powersave-v3-0-c47856d8757e@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ricardo!


I've reviewed v2 for locking issues etc., albeit without much background 
on V4L, UVC, USB yet.

If this is good enough, then please have a

Reviewed-by: Max Staudt <mstaudt@chromium.org>

