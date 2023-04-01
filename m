Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0080B6D315B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDAOdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDAOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:33:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695ACA0B;
        Sat,  1 Apr 2023 07:33:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ix20so24084233plb.3;
        Sat, 01 Apr 2023 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680359616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVMCxKkdAj5G/sHqBJwRjfivjb3c00JzonL5QvYBrDc=;
        b=oorS77R7MIzVP0hceo91ptJHWN9iXoA1WQeFlSuZGUdTpqzzj+6KEWHDb9EvFJioJB
         s7Yk/litLZVKfdHl2yWdlE2pKQ3qC3Aw3v7reTboKin+yD1gkIBCODUAYsLsZ6kMdDM+
         d7E/3CR/y4+dI3crXmJE/IC5fqv8XTyyK51Qn2x28S/dfqrqty9m6QyLUPLeOjvQSabB
         o71Lrwk67YDTb17v79gPk94omHSRIKPnRsXaQBmPEZxvNRa5W0R0NBTCs+SEx1tqU4Q5
         dSgxXViMUO5Tj6yXlV2tnPu1nCSNXT7TQOQYK0Y2WWhZkna0tkn7H+MzFuTHhWu0fti1
         q0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680359616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVMCxKkdAj5G/sHqBJwRjfivjb3c00JzonL5QvYBrDc=;
        b=CODQ2XSdzEi80XB+HeaeUJSMcmKH+uOTRw21SRAGPJGXjhOhFgf1f8gTUzmcYKY93D
         6mlNLuC9y8anlQ5XySn13ISIyaSDImi6YkzhxEG58VLc0iQUGhBL45n/5rLpswAoVs0o
         C1TpEX4m/2CIGpV7xspTkWVCaT/AMRXf924Ml5OPjwyG8a4YvB0B1Tw42BEVEwJP7x35
         o4InCiHDhs+RQs1LdFpslHuxRfpIXYsY6TsqYUJjCR37FAcHKGHDWqPuf7pZGUvFAm/c
         j6UvTMrwhRPVAGfZ2PSDA2OYr68+Cfx0oGpdXmZ1fsRaIfDwgTekG+IwAGX35ODt3107
         8ILw==
X-Gm-Message-State: AAQBX9efa9cM9UkUOP3cKkqflM+WcZKtNX2JomrDInvIyBnYJ96Etj4K
        ZP0VXdEFezm6Jm+Sxyil6068IwcHkNYl8TdEPss=
X-Google-Smtp-Source: AKy350bWY76S1g8Vj/Huvn7WWZ45nm5q5e7cFRBykceGGzehIhVjpEW9LM82jjc/w8x69HUL9jxGeorEgerr+yx+Blo=
X-Received: by 2002:a17:902:d70b:b0:1a2:8940:6da8 with SMTP id
 w11-20020a170902d70b00b001a289406da8mr3191541ply.13.1680359616143; Sat, 01
 Apr 2023 07:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230331163058.5688-1-sebastian.reichel@collabora.com>
In-Reply-To: <20230331163058.5688-1-sebastian.reichel@collabora.com>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Sat, 1 Apr 2023 16:30:53 +0200
Message-ID: <CAEwRq=q=W57W33nYe_uUDQb0cf7QkFoa0rO+EWdsuUGTN7k_Vg@mail.gmail.com>
Subject: Re: [PATCHv1 0/2] Improve RK3588 clocks and power domains support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running a QuartzPro64 with this patch set applied, everything(*)
works properly.

(*) eMMC, SD, LED, ethernet, serial, watchdog.

Are there any tests I can do to help with this ?

Regards

-- 
Vincent Legoll
