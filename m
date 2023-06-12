Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1F72BE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjFLKJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjFLKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:03:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617654EC8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:47:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5162d2373cdso7427988a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563262; x=1689155262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swDmGDg9NuCM2bjbOR+WpvDnl7t732pcpG/NR4aJRv4=;
        b=YXGYto9u8W82vnEKnTap55GQJyfR+pWShm9QBSQO2LrSJNtKo05ZAWOB16fk7flQCh
         /b4DMKE7UTiad31KITiLK3scP6Oszmw6GwqzFMPpy9c4U6sRGAcNhgy1ODbgVjWT9O06
         niVMr0SakePRGDfOfne0LnkRiTxVw76d/XAxTPyk7/D6gLLeV5Ai/DToqssNU5SuiJ38
         oZ8Ol73QSOQQbSTinCn+IF8j034Hiha12T1t+Pug66fx+ZAfNnrexutvL4LUFrjenOt5
         cYZsAeiRq5guM3JXxnXZ+HNnFjQUiXcYlB9O7MvT7wcouZFEUSA2GJGI+Ano98NkkmLL
         1tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563262; x=1689155262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swDmGDg9NuCM2bjbOR+WpvDnl7t732pcpG/NR4aJRv4=;
        b=V9decTlf9dw3Mxbpv6enjOXXUIHI4pdkD6O3ZaVbRqT6czvcdu4BKnWCTud06XorI8
         DlEIad9oRkrWuJ2AG0C8sxDUmmSl7Ixyz7TaVav50EaayOo1Z7WMny/wDHNTkO9gu8Ot
         RTTaVRC+Y+Rivc9M0YHYWaoff0fn/yCAACdrwqerJclIEVE8+6FLhR6P4h/kP7wPjryJ
         WfRnboAdkc40kgTnRecvpPEsRrUz5cf66YQVqL3DLhkQ8b1iSQRv4iSY2TptWAPPhyZa
         FifBgkZ6i4tVYxAf9wyid7ZL9gBZJ+gzU1yu20MOURMc7tdXzJBc2ExvCymvK4TaWhCr
         jviQ==
X-Gm-Message-State: AC+VfDzRgNeKQD/Of4QjWxKgRIdQtsXcZ5qs8CkKKb9YvNxuwctazrvw
        Yd9cB6bBYCIDpaFAdPA2S1/ZHKS25ttA7skflrY=
X-Google-Smtp-Source: ACHHUZ6mmtUIKzjbMdNCrJV5FA8uz7fKoiY13HgNWQYwj+87ouaFyCA+erWiLWbdyX6P8AhKPUX8LQ==
X-Received: by 2002:a05:6402:10d8:b0:50b:c630:a956 with SMTP id p24-20020a05640210d800b0050bc630a956mr4045191edu.17.1686563261847;
        Mon, 12 Jun 2023 02:47:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n17-20020aa7c691000000b005105f002fd1sm4798496edq.66.2023.06.12.02.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:47:41 -0700 (PDT)
Message-ID: <22cbfb03-1959-3883-0c10-cde5233334ab@linaro.org>
Date:   Mon, 12 Jun 2023 11:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: defconfig: Enable USB audio driver
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230612082150.20767-1-r-gunasekaran@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612082150.20767-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 10:21, Ravi Gunasekaran wrote:
> Enable the USB audio driver so that USB audio devices
> can be detected by apps such as aplay.

defconfig is for development, not for using by distro. Why do you need
for development of arm64 kernel USB audio? Commit msg should explain this.


Best regards,
Krzysztof

