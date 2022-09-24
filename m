Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414C05E8B67
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiIXKQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiIXKQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:16:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8A8A182;
        Sat, 24 Sep 2022 03:16:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so3428598wrm.2;
        Sat, 24 Sep 2022 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QRTSu1O0HIpoXO2imWD0xHZMuEivGpArSWdd+grYI2w=;
        b=RoshO2+BRIF+C001sPHXQ7DvKmu7ufxWBFGZzhbRYdGwDIpMvMiesVpV394gIJ1sH/
         nQaxw4IgN9B9slHqzmOqL5K0DdNZzARkhrNAY6ahAnNxFrZYaH06EVAZxRl4eHkPE+DQ
         d7jYxqlJHb1Z6ehKreUlM4iKeWA0mwNTs0vjG93wW/flfybwLXgC+k7AGxPTPsazL6y5
         LVxXC6fBA5Vl/PcJbUUWCJhuiU4hijpVw/mePEvNJu7kNSt0fl1emVPAoRGrTakYNccy
         UfYu0PJ9JCskPOPHVLh2s5bwznYdKrNIl1qUifRqd2cXNtWrkAO2oNATIiwDGdGjgXng
         myQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QRTSu1O0HIpoXO2imWD0xHZMuEivGpArSWdd+grYI2w=;
        b=AqTyqv4jzNpuWGMmQp1bqveoQ0V1QzDeCbbOSoEu+FFP5tpWmP9Yw1SmL4OGPlIGy0
         zYpsW41lRSLW6AdCxknBy8lccIt4q7e7L7PZh5b1K0Gi0ANl+RqSJvqWn1ZscIBIIr7r
         7q4UmmYQwdX0XoI25VpKRvWfI2ocHcbvZWLzL49h2c2O6NJKxWb93uBUeAGCeSuFYY5o
         wI5AkV6Oj+MbAR8daQvnppGROkCrVfsxc2qT7wfeR73H7KIt9RYNhJw6L7XxUxt+t0lU
         xAU2VZXtA94HvqhJYjznRsSVMYyUrXjtmhBULMb5N/4Y9dVl1xhRTJ2U12syJP/WGnZJ
         +HdQ==
X-Gm-Message-State: ACrzQf39i0h45p10WapXN8aDXRFjgNUs7wmvMQJJcSuRUaLZMd5Tsaoj
        4qh+hy0dBv9/Q2TPIdlmq9zrPrXvbAM=
X-Google-Smtp-Source: AMsMyM7XmVc9uSASAIp7aoJGsljOtOFMuG78u6WMjg/dVOSdPpAo3pwyjk3EcaPgBuEajhneLJLu4Q==
X-Received: by 2002:a5d:6d82:0:b0:22b:b9f:d7fb with SMTP id l2-20020a5d6d82000000b0022b0b9fd7fbmr7522130wrs.580.1664014575008;
        Sat, 24 Sep 2022 03:16:15 -0700 (PDT)
Received: from localhost.localdomain ([5.25.100.2])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d6642000000b0022ac61ebb14sm9178253wrw.22.2022.09.24.03.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 03:16:14 -0700 (PDT)
From:   Kerem Karabay <kekrby@gmail.com>
To:     kekrby@gmail.com
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] HID: apple: enable APPLE_ISO_TILDE_QUIRK for the keyboards of Macs with the T2 chip
Date:   Sat, 24 Sep 2022 13:15:59 +0300
Message-Id: <20220924101559.10744-1-kekrby@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910094354.12359-2-kekrby@gmail.com>
References: <20220910094354.12359-2-kekrby@gmail.com>
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

Hi,

I just sent a new version of this series, containing a bug fix, which can be
found at https://lore.kernel.org/all/20220924095306.8852-1-kekrby@gmail.com/.

Best wishes,
Kerem
