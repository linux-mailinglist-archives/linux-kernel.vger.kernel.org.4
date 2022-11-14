Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D66275EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiKNGaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:30:45 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C158E0DF;
        Sun, 13 Nov 2022 22:30:43 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id d9so11577245wrm.13;
        Sun, 13 Nov 2022 22:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgXHANZ8M58hWgR57QCgeYzsoA5NGl2ZEic8AnHQx1M=;
        b=RtviJRPKazSuTrGEkDQ7MXwGhYXxCxkzcl5q2M8r89aeEN9m7jxBdCxydPdU5GXrwH
         1gTDNjS9fotr7asWdNt8JyetUhKx4z7FtNgYJXH85SSxHSpybgtNNJWuHuOCWvXxDfvc
         o+TMVXkjo71bGru8+Z4q6v7CfcJWgZ+lQXNn1yx4tyiEV6vqQmV11PcjI8xzMW3As8aS
         YyWRc9PgQ+qjA18dB/Ei8iMsqR+mRlh17OSI+NBWaOOtzZQsUbGF/CDhN1Dp10SSDufc
         317eGcnHob4F+niBeA2XVZUwt+K84rfnIiglgbwEpAmowieiSxlPHihrtUUCRXrnJ8k2
         Eksg==
X-Gm-Message-State: ANoB5pkrYC+M5eiKe/JZcj4iy8VtuJLZM/LBy5E6vhBNg0ftWAGerZfL
        LKExuocl8HdlcHaAxyms7g8jWyu3+is=
X-Google-Smtp-Source: AA0mqf5FebTso67LyCISPFGwUp+QMeujN258yCJoxEv3iH9cbdsWcbmffyTSJJVkMccX3F5sOya6xA==
X-Received: by 2002:adf:f207:0:b0:236:8322:4be9 with SMTP id p7-20020adff207000000b0023683224be9mr6474911wro.171.1668407441820;
        Sun, 13 Nov 2022 22:30:41 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c1d0900b003cf878c4468sm18530130wms.5.2022.11.13.22.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:30:41 -0800 (PST)
Message-ID: <b0d0abd2-e672-f1f4-3695-7fb0952faae0@kernel.org>
Date:   Mon, 14 Nov 2022 07:30:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] n_tty: Rename tail to old_tail in n_tty_read()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <22b37499-ff9a-7fc1-f6e0-58411328d122@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <22b37499-ff9a-7fc1-f6e0-58411328d122@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 11. 22, 15:25, Ilpo Järvinen wrote:
> The local tail variable in n_tty_read() is used for one purpose, it
> keeps the old tail. Thus, rename it appropriately to improve code
> readability.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs

