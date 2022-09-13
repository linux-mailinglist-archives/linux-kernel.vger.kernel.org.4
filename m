Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DAF5B78E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiIMRzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiIMRzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:55:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CE6E0C7;
        Tue, 13 Sep 2022 09:54:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l10so12423986plb.10;
        Tue, 13 Sep 2022 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tj/y2R3Cw/vtMo2CMiLLgLOFf+kwPiBNNxkBB8CDEbQ=;
        b=Y3RK4X3XH624gow0ivIrqP3F39itnqDtSlYTamx3GD7bKVjqm6t2pdhRsdPLRc+5Kk
         flSAsagunvM4xkaLqpriS0p+adIN/4jzO+yqzLYF6NqG8ejBDDA5wffXbC099hVwykm+
         NjMOxSGAKwgpvE2hzucR8HIpsvC9x9m0EEXlA3dAUjsNm7Wg41WDaG5bV/VRlABs00W9
         YXtN12sgohMiWPUkfwk1d22J/M1t8SNUH37I6lcs60lbQEJr2tfMv9ggjfWH26ZrKDcW
         TE1vr7r9QvYfSOdVXkciMS+Eh6m+66Mmw++yqDIuT+VevfgbGe+d5cK83EaxYq/8Z7Iw
         WFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tj/y2R3Cw/vtMo2CMiLLgLOFf+kwPiBNNxkBB8CDEbQ=;
        b=H7k9va9rSuXhAXlJh0xIL19qEp+mEyxJOnZFBKMVAbgsk8JjzsiKQvHrv5lA9L+G24
         XZpY2qPVYNpxHRmIMQsi8dNZmwtEVNNai93fbNFCRTEeB3LzKQHmoi8KSyhcy+MO5811
         N96vqPa4GJrwMU1wb/LL3sysXoRZjhi36QClHBArXocVCju0DiTSU109/L2F5xc5p9lA
         V67J7fahEvrzvk2YKbp18CmpJ1SqcROfad1KqvNJgz9lMPYiA/m/1aWHHLDnL+ZO6OML
         HlWtczaQksliYgi5kRHZVaWixwYzfmBOe8sZ9VibSxcAkX8FKcyk1Ce8ofBXaN9ZK9ml
         Nf6Q==
X-Gm-Message-State: ACrzQf1KV+WLvkvdsVN5knU8OAwRYrfguhVbqydn67KpAKxuxP4sweYk
        7EX4a6pv71Pjbtydm+fSXvRR1RbRLinIRw==
X-Google-Smtp-Source: AMsMyM4BPXD1Zj3M7Hp//nlTHalCsLR69ABT2cT522VWfp1BCumGEWNGMr0caRucSDDzwSLZuXhXkQ==
X-Received: by 2002:a17:90b:180d:b0:202:7cf6:9f9b with SMTP id lw13-20020a17090b180d00b002027cf69f9bmr220475pjb.160.1663088080547;
        Tue, 13 Sep 2022 09:54:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:b126:15e1:55ae:d9eb])
        by smtp.gmail.com with ESMTPSA id md22-20020a17090b23d600b0020061f4c907sm7586448pjb.7.2022.09.13.09.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:54:40 -0700 (PDT)
Date:   Tue, 13 Sep 2022 09:54:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: mtk-pmic-keys - Add support for MT6331 PMIC
 keys
Message-ID: <YyC1zRlf+AUSFKnv@google.com>
References: <20220913123941.385349-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913123941.385349-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 02:39:41PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for PMIC Keys of the MT6331 PMIC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied, thank you. But we also need to add the compatible to the list
in Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

Thanks.

-- 
Dmitry
