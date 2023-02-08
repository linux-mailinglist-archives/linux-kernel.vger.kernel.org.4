Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0E268F740
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjBHSjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjBHSjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:39:18 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51425195;
        Wed,  8 Feb 2023 10:39:18 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t17so13777066pfj.0;
        Wed, 08 Feb 2023 10:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHj16xp4ZW1yTrDpkoKel1OTGpR34CSGf0oUBv2wd28=;
        b=XFNCdBdlz5wvwjqtsyl7gFkSJFAIBNKBqxQQW10ApTVQgjurT2Su8Ici3pAElE584g
         NJB6unJ8Gao1PRTJWWU6SUtqDS82iqviValG4p8ph2tU+aUY1nktOkzeKOaDpOc3e3jP
         Kja19iH15cOPCbKFqJpgwt1OS0SxjkgtWKP9XqmbOm/r7D0thWTP0ehT8DFT9C9uFAfr
         +ePTsBKiT9RFWiP7HGZulmJmTek9KoBHltVp6xmgIlm+ZHKOdzrBU6bBF68w8/zsBeW6
         Fl3uhOvJPsFHesmUuUigvjRbOlTH08wc7wvC2dYeJNWbbg7asycdkiWYz/KN69CI51H4
         6nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHj16xp4ZW1yTrDpkoKel1OTGpR34CSGf0oUBv2wd28=;
        b=45K3nhS8/5y6G7qnqHcuIyJPhFND6nQnXrr5vuH5yQAhJsUtTRcuf4LSTmW+zpeGRZ
         SmNsLtYn/SuXB+rUkvdz17M/S/ZFppsUhzsUM5c+ETgyLkPa30EWn3ikrOPtDh8yKCPO
         TzGqX3ZxDc4zVlxneJKA+KQs3CrxS37V27qhhL/yZCmYKyxyvFoMFpKxn+XOv7PRPNv9
         RnI5mZgjlqybMjKESr4Jz7oB0GMGSy4SoKZ1qkwOf56ISUgb4wMWP6s0GDRe3+vTHsMe
         AyDV/PJ0HBZcrFgC0f+ipRn5G5r1/1BT0yaqtsuq2GvZSkMRlbphNpTwAzJC+m6Zcskl
         9sUg==
X-Gm-Message-State: AO0yUKVp/1ejbERb8e52yKIwzdZxzdhH+AKVf3nZVDvk0nKw8wpshei1
        rv4BM6u+j9sF4yecHgXONep2YlJ34Rb0iw==
X-Google-Smtp-Source: AK7set+0zAh5zqgFyuOU503TekCEVGVOTV2Xv9L8JGqcTl6dfdVX7gpZqirg9M3x6B9Q3vj37zRaoA==
X-Received: by 2002:a62:1c58:0:b0:5a8:5101:d667 with SMTP id c85-20020a621c58000000b005a85101d667mr310320pfc.22.1675881557732;
        Wed, 08 Feb 2023 10:39:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h38-20020a631226000000b004fb10399da2sm3509038pgl.56.2023.02.08.10.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:39:16 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: broadcom: stringray: Fix GICv3 ITS node name
Date:   Wed,  8 Feb 2023 10:39:15 -0800
Message-Id: <20230208183915.863520-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207234709.201229-1-robh@kernel.org>
References: <20230207234709.201229-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Feb 2023 17:47:09 -0600, Rob Herring <robh@kernel.org> wrote:
> The GICv3 ITS is an MSI controller, therefore its node name should be
> 'msi-controller'.
> 
> While we're here, fix the unit-address which shouldn't have a comma.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
