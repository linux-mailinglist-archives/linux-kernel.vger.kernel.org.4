Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD360E290
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiJZNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiJZNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:49:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F412310250B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:48:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w189so13870035pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=perTojXhOIkVoIxZmL7uixXc0TfGA0sMyLeC3fzxIlE=;
        b=aagNXPdSImuDfcBn0cDGfiEdse2Bw1UYAgM4guo6MrC3qWnLgmiceDLl+WlEFpSkC1
         2r3kUh4QRch1dkmg9WPYMl8t0xjUosWVLgpX2r7RC6xaZm6tUMOIfAt6mPHTi6L0YCHi
         f6Xhl2V4Rez5PDqhvK5Z0A9I0pVMM2UPpbKSnMT3mCxVYGNVTELqhuh9LlpIyeReygMt
         tX6GUxHdVIn58/MybOVSnqjmqIN/n4YL070Rg+KYZFnK/UiounvX+lHPwJUVEpmgNs+n
         wTRdbkfGu43nTi5LwoBK0gyF0EFY/5LRxdBKfwgeQ3JiTDb/DTRxrayad8NiyJeoFLcA
         rEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=perTojXhOIkVoIxZmL7uixXc0TfGA0sMyLeC3fzxIlE=;
        b=6IxiBr4brf5yKL/EOI4/K07MIhxzVf4VDeyeseOMdd+A+wzpXQk14RUfX3rLSFZh0E
         veEHTn3YtWd5h8dY97TNDfK1mYBc/drObOR1gEZc6VQl+/wg62CL+Ktx/zC7XD/qjBk2
         GYXcyKg/kCSoQAL/LyKLPvA/ENdjVoYHkv8Kl8IIzMkkd3hOF6RNTnKlm+C6CaX5seFQ
         8CNAErno56OLt0Buk+sRlzcHV85sReQj1bNn79/R/wnNXRgwvDovIFju2hq8T2jhd6+b
         ZZ7jxuBy2dHH6mQYrF1+AP5SNDNL8s7jUQPcvND94ANdSSxzWgyZtlgnNfrqNYxWMxyz
         0D/A==
X-Gm-Message-State: ACrzQf0gWtcFO3MCzyjQ1qZKTPJBLX9pWKCrejZ6Y6VW6y8BJnSmW+3F
        tAqR1kSfYFeX3YqAE44IKjldDQ==
X-Google-Smtp-Source: AMsMyM47/2wydw0Q7j/VTrsT+GrAjI8rM35XtHTmTpQM647Z7CnM4cUc7mPeKpbbUfboFyLNyR5wcQ==
X-Received: by 2002:a63:5415:0:b0:439:e932:e025 with SMTP id i21-20020a635415000000b00439e932e025mr37107108pgb.63.1666792128379;
        Wed, 26 Oct 2022 06:48:48 -0700 (PDT)
Received: from localhost ([135.180.227.132])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b00172b87d9770sm2972412plg.81.2022.10.26.06.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:48:48 -0700 (PDT)
In-Reply-To: <20220925004757.9089-1-heinrich.schuchardt@canonical.com>
References: <20220925004757.9089-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] riscv/vdso: typo therefor
Message-Id: <166679186656.19249.8222101751661120126.b4-ty@rivosinc.com>
Date:   Wed, 26 Oct 2022 06:44:26 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022 02:47:57 +0200, Heinrich Schuchardt wrote:
> The adverbs 'therefor' and 'therefore' have different meaning.
> As the meaning here is 'consequently' the spelling should be 'therefore'.
> 
> 

Applied, thanks!

[1/1] riscv/vdso: typo therefor
      commit: d233ab3c5c5ed4b3d2201bddb71dab5a2946c31b

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
