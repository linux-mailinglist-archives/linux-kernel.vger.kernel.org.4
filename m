Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E079727B78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjFHJce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjFHJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:31:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1AE2727
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:31:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30c4775d05bso255424f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686216709; x=1688808709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2nCVCrZOkwudtPdu8IfLznRzJa7lQBEe+KUEz9jSjI=;
        b=ZjkbQBZm7Dw969pcsyWCSsJ0MnYKqEAQbXFJU/2sVFXKohiH6CJEfMUuOF4ObEDdQU
         go/8wjrFCceGpauw8oxTdLhFGSVRBS1tep/cUye9RPDK1KXSaUUnBUZn4eT9x/3E9hqK
         KUqBHec+rGdQmlhmzLJAH5Bwy15Fx6HWdvU6YcV55HwzcG1Z4lFR5nnZdFQoskea1uoi
         LgjUYR/eIfkKyCCyHsikPfm9BeZeM/dVdifqlLMFI4N6F89SwU5lVL868pt6Fd6j8qOR
         ftpRlCewejJ40XYXibu/GvzJZ8j1NvCp5o+5i4gBE205mGaZhCMXMVXpSwrB5fFOEqxW
         GkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216709; x=1688808709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2nCVCrZOkwudtPdu8IfLznRzJa7lQBEe+KUEz9jSjI=;
        b=Jh+KYI7JMO3O+1hN8xeyeA1suDUvWsmdhNGfvK//c46iUcrGc5SCdlqEDo9QUqXLTT
         ioNg6EK6c6uhewAoRzR5j4l10VsTn9jTb+hbHkbvg6cdyWgt+K+9VzCdkbLT9wFvfGUS
         eqCcGI9hZkTYwTV/9qk1jmrYY1/sAjTgqP2loiaCzXUpVIiDPalwtuWp8Ue1nU0mx08B
         EoHX2QYjFKJgTfTUO+OTxo0ld7kXfkR3+5QAubE5mRqtQN00EWOslo9G6GwTyBnlIqQE
         sCzx1pZhKDYOcI/L0EjQYgHHZdEuhgPozcnc6ZWB456Axvw1y90wcck094UnXEZvmoIs
         fziA==
X-Gm-Message-State: AC+VfDyEoxn086s3hsodzQFTIC19yaU2eJhUqXbfYuQf/wr3rXPvwLpG
        YQ1kdsgGioNVngUl0RSA3aWIzQ==
X-Google-Smtp-Source: ACHHUZ40NzTTDqWA9zTHhxTdub04YOLlEmvfv0QlDvpHjEWVBGENTRh9QrlohidOCVV9ZUBd14W1nQ==
X-Received: by 2002:a5d:490f:0:b0:30a:ea8b:447d with SMTP id x15-20020a5d490f000000b0030aea8b447dmr6135595wrq.40.1686216709383;
        Thu, 08 Jun 2023 02:31:49 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe101000000b0030e5a63e2dbsm1018641wrz.80.2023.06.08.02.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:31:48 -0700 (PDT)
Message-ID: <adb0c4f8-f2f6-c587-9452-2205d0180ad7@baylibre.com>
Date:   Thu, 8 Jun 2023 11:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] ASoC: mediatek: mt8188-mt6359: Compress of_device_id
 entries
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-2-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230608084727.74403-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 10:47, AngeloGioacchino Del Regno wrote:
> Those entries fit in one line: compress them to reduce line count.
> While at it, also add the sentinel comment to the last entry.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

