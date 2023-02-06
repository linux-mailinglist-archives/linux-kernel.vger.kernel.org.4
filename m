Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3368B799
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBFInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBFIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:42:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047011DBAC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:42:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8116532wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE327sjgKmScy+1bnD3WKWCENrHEfYM/F8714Ak6Hu4=;
        b=xI7JhiS1vmRN3KOSmYpBb27mCSKrdjiBahpnOGUXRNx3XDw6ekzEcICbEcmn9K43vN
         jcDp4fpbaCJzF7xesezNnlz/WCol73gCl9OjN0V75E3XyJ4Df09mY45/ubYWASSz7NHZ
         IMvFnhytQVEOM+UDT4g5w3Iea9XstH+HDP76JnStIyBGh1Xg7FtD5IJ5ragIqBS8xIWw
         JG+v4CTQDhTwBSCJ1kFQYM6WUYdu/7qBbK5nddG0a3YV4//MyvqUtIUAuvqBjEN8wO7L
         O6+EighIMxUNj2LAZ2W9xOMgp3zdvrBLEZc0qEv4I9WoSNkBYSKYNXg8pUecH4yBPF0j
         M6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE327sjgKmScy+1bnD3WKWCENrHEfYM/F8714Ak6Hu4=;
        b=rfwZN2yYEPSIc05+GpmNjUnuKP2RcNqpTbVQzYp75qNK1qREjDYmwZRs1v/QXYRDl/
         1o6FXfIVyFdVIwLFeYpFnzoRMJPf7l55KEutiAEzuYczVuv988x7nWMkRmulauwRxZRr
         5eQCRNZeCssNBErFP+4Xveo508zvGSBRBswtWZKd6ITwHORl5QY58UWjn7gHfLvRmTBK
         s7biZglUmB80r80J7dC7VRJPwN63z55W8aGWF1RFcNsi784n8NsoK3eAF80+7jc/D4jv
         HROLQVW9LrFLlgiz0sf4LDIQFUDvTxwqyF5ThsZZA/vGTPJH+eytcEGUvt1YCfNGCSxZ
         sU4Q==
X-Gm-Message-State: AO0yUKVDXFpN1xJO4zWWK7Xrr1PRkcooFMhLHW2XanSPocq0QS5yvPP5
        2sADzxM9uVyY78/ppyLK0iGPLw==
X-Google-Smtp-Source: AK7set/k3iebp56HtRvylh1Q5s6xc+VIaCiBCNBL3n1tsYWIT76P5hrK/RK/edVEFgPVh59+a3YyXw==
X-Received: by 2002:a05:600c:1e89:b0:3dc:5b48:ee5 with SMTP id be9-20020a05600c1e8900b003dc5b480ee5mr18287612wmb.2.1675672945695;
        Mon, 06 Feb 2023 00:42:25 -0800 (PST)
Received: from 1.. ([82.77.80.113])
        by smtp.gmail.com with ESMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm11225960wmc.4.2023.02.06.00.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 00:42:25 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Sort headers alphabetically
Date:   Mon,  6 Feb 2023 10:42:21 +0200
Message-Id: <167567282461.10447.10704477322040146991.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202144628.14443-1-tudor.ambarus@linaro.org>
References: <20230202144628.14443-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=516; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=1+8qw4rrsbhFfDsWmnoxHPmexlC53wUEVJGKbUiiZRM=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBj4L1skQGkBouWgdqmuA4EK+YsgRBDnZenLXEVu rppEBSnEkyJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCY+C9bAAKCRBLVU9HpY0U 6R9GB/94MWry0wf01KfEgc/gOwxg0QnJ19izMA0XmxnGjLOq8ajIpFB7O/Vy1Ox+StEhp3pBFu9 v8q+3yGN46K/SLBwAxVnGW6Fo2smPUeqLjX9J2vmhTrSrs8Jw9Hj9suokEe77z6aI3CTG+W1y9H uCy4FfXwH9QjJdSUTvJkFgZQekgrCdv/iDOKeQcRPwQ6ijRSmtnqJEUElni6SzUf1oB0Y9C9psL uSBV8WrHxUP67jeQkmA+JhtsM6GvCf9ucD1U3vPO61bstgGIp3+vTZkUSFzaEKEI0NA9zEtiFkM 4DqZdFyNthEv6F3tThznuMbhLeranRTtv9GRZmcyyUxkY9YV
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023 16:46:28 +0200, Tudor Ambarus wrote:
> Sort headers alphabetically - it helps locating duplicates, and makes it
> easier to figure out where to insert new headers. Alphabetic order should
> also prove that each header is self-contained, i.e. can be included without
> prerequisites.
> 
> 

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: Sort headers alphabetically
      https://git.kernel.org/mtd/c/893fd950c89d

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
