Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A046EDA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjDYDIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjDYDIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:08:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F0AA8;
        Mon, 24 Apr 2023 20:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=psTvjtQPzA5Vi6Y2pdFr8jOV8iAK+uA3UqfeHcAS958=; b=HWWF/JYD2yumveJ8IzBuFgEKNv
        I0qryq/pWXC9jm9ykvpqbgP/BCxsoKFH0sH/Yj5QpXKBfcTZhyknZjOFt8GiPqv/Np9oxu8tuqbg0
        6o5Lwh/dKl4YZ+gD9Dmzw5LglXp7w4n9rrTLeNelHy+TyaQCXdt5vCCyb9Ff33IdwCNdw4pvkl1jd
        UahJY/KhHJzag+FDiAiPN+k+0R5Wf6aRXurGwcUBBX2dnAENZyUSLmW5AKPDVCZ/zZmKhlHpWJ9Au
        f5PS+D12Dezsc4WZMFP1x9ik1QjB2NlFjfquj9VMOF6Y+73P/ZY4R+F+nCHrk7y3oMQLSIk/16qoT
        bAfovltQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pr92G-0004kL-0e;
        Tue, 25 Apr 2023 03:08:08 +0000
Message-ID: <956006f7-70d6-f00e-8919-cbfbf2a5ef02@infradead.org>
Date:   Mon, 24 Apr 2023 20:08:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/4] platform/x86: wmi: Add kernel doc comments
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424222939.208137-1-W_Armin@gmx.de>
 <20230424222939.208137-2-W_Armin@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230424222939.208137-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/24/23 15:29, Armin Wolf wrote:
> Add kernel doc comments useful for documenting the functions/structs
> used to interact with the WMI driver core.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 51 +++++++++++++++++++++++++++++++-------
>  include/linux/wmi.h        | 41 +++++++++++++++++++++++++++---
>  2 files changed, 80 insertions(+), 12 deletions(-)
> 

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
