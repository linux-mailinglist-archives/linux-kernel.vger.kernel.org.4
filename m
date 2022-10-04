Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3531B5F47D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJDQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJDQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:42:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD95F20E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:42:00 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e205so10953734iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Fv/RATIKH7DVnVoK46aeiXnGHzrASEQkGihJLuSD98Q=;
        b=OxB4M4DCGeQWSb2yecuTG5Cooq6Vsqk9UdlZpr80kpwsgwgoAkHd9pyp8lU2VUeOSR
         GJK6bnOUYbWolSJCgZEt9BVXvKOD5jGatt/lqHTDkZ0HHve0EcUrxEE+f67pwlZ8M2Pt
         hFUz9hk6E3MEUNVwvjRdg/QNCMnVCFgJrLxYvfKFUVqeVttBU49HnrLk0veT3V5rA6qn
         4zvLnjbyjj9L/E35VQAld0GOlaF3mPXb8orcpULsEkM7Y87EV9FOpY3222UXpfwHmYCO
         qBCJaK7yutyJzmbAeJFbNmY71FTlq+PbPtvyGmCddLWMgeeKxaYrnQoTAnqmmygijPLI
         O0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Fv/RATIKH7DVnVoK46aeiXnGHzrASEQkGihJLuSD98Q=;
        b=kZK2a8iFHDhOModTujGXMWVbZ4eKX83dzvlM0rqIweA2TUMbGNcuchTn841F5MJUgq
         4JQKatu/81u6xCetzu95fhJeR/6gzqqx91xKqIyZRkAMfoq11ly3scq4vDB/QlfYe2JJ
         oKQLSlfC/93D2HRU3RHVK0tFUC933j2b8xr+/U957GpDwmzY5tQGgMt4haQNsosqrZWk
         yZ+4MQle749810I5zJGfl1OQ6zzktswmnfRv1kZviyfPAT8cGgWFNgGksKpPBs/gMouX
         3yAQI01535VM/1dmVWzd8bQC5BvS0LExO5bp9cog67RH31q/94FsgxEZPx8sMz4QnTwn
         VQSw==
X-Gm-Message-State: ACrzQf0iN6jCF5Gvf8AggXioUqXHPapktVa9rAeH1aY/fZ37iCHrkR3B
        f7fEGxOq4cdMCLNyTpoBKhCGeg==
X-Google-Smtp-Source: AMsMyM4NeENQ9RrdgmRLfa9eppQvWRZBwzbHLgFLi2NlheGpPAbafceQz30mT1kiJmMMyHXxNKYNgw==
X-Received: by 2002:a05:6602:3ca:b0:6a4:16a0:9862 with SMTP id g10-20020a05660203ca00b006a416a09862mr11681253iov.217.1664901720258;
        Tue, 04 Oct 2022 09:42:00 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c72-20020a02964e000000b003633ef39bd3sm1638823jai.92.2022.10.04.09.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:41:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20221003202511.5124-1-jonathan.derrick@linux.dev>
References: <20221003202511.5124-1-jonathan.derrick@linux.dev>
Subject: Re: [PATCH] MAINTAINERS: Update SED-Opal Maintainers
Message-Id: <166490171926.91699.11306873216901064768.b4-ty@kernel.dk>
Date:   Tue, 04 Oct 2022 10:41:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 14:25:11 -0600, Jonathan Derrick wrote:
> Add my new email address and remove Revanth
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update SED-Opal Maintainers
      commit: 1d800f32b2574c1d055984ad17223198caddbb54

Best regards,
-- 
Jens Axboe


