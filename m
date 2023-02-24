Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABA6A1876
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBXJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBXJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:04:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C910F4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:04:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso2125226pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNH9BgItuJxPa+eQE400FTpJfbjpuq0SQX7Oz1zEQmQ=;
        b=JGmDr8Aw8icVTyZLLXFiLcpuosCA6vb0fgEOTMZH1ZDfNETpXH/qb/2VLqnM8ZPBcI
         kUAiFNFrTSv/3bI54f7cdTFAACDt7jIkSExuH3W/zKt3n+3nrvIai3cZjYX0/XQMrfzm
         Ow8lxCAsXHbVLY+u1DzOVFMFlTV2wsNZT7vf4DCwuOQge0A3Hb4MWmvL/jSWHWLFk4TF
         8xeoNKbifzzOWewdhstp3x7vtPld5i+R28i3RMNgN3SnuZxrcPo2y3kEJxxImrtiF/IC
         iehGkHDYfldfJP6m0i/SfNe4oapLZkW0/VhUrOFMK4XICM2ydmJChs9AzwNDrgwq9jDv
         epiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNH9BgItuJxPa+eQE400FTpJfbjpuq0SQX7Oz1zEQmQ=;
        b=OeYfFP2XIvKExYFzBT1dB58UjeUx5PHffHuWnr6RNhAQ7oWn15JmVMD7hPPy6AiSgH
         VVAvVwVrfkYXTTKkgpSW/MXojmVUFTuzPGvffki/eGH1w1rW2T7RqSoOHQzDtttBBp+j
         bfjv3UQS0FU+NJ4P9dHw2txJmBxkcMcOgOO3JzsjoTY6aLASuEJ2rSDum1ppdvXQ5oGS
         5YH89tVsApDMI62wNAE/1ezkbHjWpHZj382tFfNu47tpwV3mn+xO5iACcv0liq1yWIS8
         BEOK7UIQMNRTEXvFsldok7/wed58wDDfj9JmO2cUxE9mvXW1A8vJSb4ITGEN0gVCyhE3
         6t4A==
X-Gm-Message-State: AO0yUKXvDuiVq7rj5DrGFVie9g+6qGoAQjuMqQdoj/cYnR6/ZoCew2tR
        tGj0jpgnKyyWvh7swnJbRlBjMjF4qbf0gdOaaiI=
X-Google-Smtp-Source: AK7set/WHQxm63cNc7enn7Z9b+Nju1snHTscYc6ReT+6G8jFapodfkn6Jy9fgCz6K1/tKYcu1YQjShwDzauj5eLGgWg=
X-Received: by 2002:a17:90a:154a:b0:237:4a5d:5a57 with SMTP id
 y10-20020a17090a154a00b002374a5d5a57mr1413804pja.1.1677229484556; Fri, 24 Feb
 2023 01:04:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:522:2798:b0:4cd:649a:64b5 with HTTP; Fri, 24 Feb 2023
 01:04:44 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <angelaemmanuel672@gmail.com>
Date:   Fri, 24 Feb 2023 01:04:44 -0800
Message-ID: <CA+OK53kDEZFAHt2cnDf_xOSKutfTksSjbP6S8Bmnm=4hpwy5Tw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,did you receive my message?
