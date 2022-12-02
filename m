Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A6640E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiLBTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiLBTec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:34:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AECA6074
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:34:31 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cm20so5857004pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKH0NEh77yV4wvtLOjJVTi1i8AQWY9dex+H1W1Fhwq0=;
        b=RbUskjKOUqkcXYUt9KFHk3fKCe1SFqqeB2yqAarXXdadL4QLZq3X8CuBmgo8K4Qb+M
         41dfcu2idcceThfdOToVv7KCKT1Hm6DzE7fQTwQDfd1+OrHlQ8hOdFirKgXdvciLTqOG
         Q3bqK3YA0hfAuQKuf+WwKpefQPSuwP4bJIsVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKH0NEh77yV4wvtLOjJVTi1i8AQWY9dex+H1W1Fhwq0=;
        b=YhSR/kRqpmHD2Aa5QLH988sKKHg9QAbKx5paGLL1fMpKcjeyGiK6xeB3UsUF8ORfI3
         AMSOHV44Slitp5auxQqCQRjDOLpPbXdM/EH4FTN3oeelDdTDGMv09xA3cdKwkLPPv09q
         ssw5pX5Enc5Q+LqeHDRyXlaQfbi5dU44qenb8r/bU570hYhEDT96aN4xgvs5b9oquinw
         Fn20aFCYmtd2gy4TQ+lB5rPPQGsDDV14dFWhqplkduei+YGr+2Ibzzfy6aYai1URXOWJ
         EwRm/VLJKGeuqZ1UMD9aMzXxV4ap/1yfHwZmWuxSIJwyV6D4l+YDoJ9VNauG4FLZbPvI
         FU1g==
X-Gm-Message-State: ANoB5pmDtE5eMEzdvp/KzODq5Kwx+go1oMubgPA24hjJJsI4pImRCURF
        f7sFNkUZ5EvgqFqT/sKK4puECA==
X-Google-Smtp-Source: AA0mqf6NLNcreee2Iv8UHP6rKGe1f/bh9BAAa7Cg25bGvqECDiPCfVXZko3mLikadl1YGB4moEMRtg==
X-Received: by 2002:a17:90b:3944:b0:214:1df0:fe53 with SMTP id oe4-20020a17090b394400b002141df0fe53mr81731724pjb.214.1670009671487;
        Fri, 02 Dec 2022 11:34:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b00189847cd4acsm6014347pla.237.2022.12.02.11.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:34:30 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     rdunlap@infradead.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] seccomp: document the "filter_count" field
Date:   Fri,  2 Dec 2022 11:34:28 -0800
Message-Id: <167000966716.1833843.16909918406362671977.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202073953.14677-1-rdunlap@infradead.org>
References: <20221202073953.14677-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 23:39:53 -0800, Randy Dunlap wrote:
> Add missing kernel-doc for the 'filter_count' field in struct seccomp.
> 
> seccomp.h:40: warning: Function parameter or member 'filter_count' not described in 'seccomp'
> 
> 

Applied to for-next/seccomp, thanks!

[1/1] seccomp: document the "filter_count" field
      https://git.kernel.org/kees/c/b9069728a70c

-- 
Kees Cook

