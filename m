Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B065D616ACA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKBRbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKBRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:30:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7D23894;
        Wed,  2 Nov 2022 10:30:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so29311325lfb.13;
        Wed, 02 Nov 2022 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QdwHLWN9JgIy1P9fttxc+d18Dw/3HwDTJh4LM3PgiY=;
        b=bgfXp8DLeJTVRft2cQmhxdkr98lx4LtNdcJSXFRgLFclfwFQU4zpwIMEbQgAEW5ITy
         mINNuMmD0BHEAh3E53gjq3l4uCxXTsKmSB4MSCSTq/WburTv6X3uZi+RMw+iGl2uHwC8
         j5xDZ4dhcdHaMMvAeAuxzestUL8BH/C4K+z3NxLnEIf26GjAypI10RBsmjGTisXN5DKq
         G7FhdrfllretpMvom5A6y7ZYL28JiBfxHsBgdFGTCw6R3LR3/Rc3xryO2AZFFOITPu0m
         S1ugoHdMPxqiwGH8txMC8qwTSlsT29l/7e9TmzCbs9m+cePDcfFJHKfU4qALviA7okh4
         MLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QdwHLWN9JgIy1P9fttxc+d18Dw/3HwDTJh4LM3PgiY=;
        b=qQEZO2EfkciODrcK7E+sZOb39CU7IrMdf3Q/ZUJy1U6jmZbshDQe5Me1Wx0zHDK1In
         fm7tr16msjdQbCN+XGxOkwZcOEZ8T6rltIX41OaZMXJoZ5LniN/slNLImYIXvUONhAfY
         78TfVrss41zQRY/wMp6Upu65NOC7Goyu9AaVIIjmO9aP/RPuMrldHgXkYtMC+73P4A9G
         5Gfu8IBvKIeaMBd2uWNi4BaayX6bdw0m7/lRUy7aDsC+s5dbpTIZM9NoPBpMHK7u1bjK
         7CO4RcVxU3bN6tu+V01Gho6Ry1uNtsAi7rrrBZYzNMG/+Dk1ZuuFJXjuIzUL9P4zI0G/
         d/vg==
X-Gm-Message-State: ACrzQf1kQEcf/ik8fUAKOWXjwgf40Uoml1dryr8X/hSC6nxgNADcUnCs
        rxKDAu8MxWAE5kA5Z73yeJ4149WMz/w=
X-Google-Smtp-Source: AMsMyM6+b+ayMMCi1R+jT3lZwdHYJfYeaIQTePZaaIcUe6XaP40gcs6mi4eqVGdFDea5luu/aMWytQ==
X-Received: by 2002:ac2:4ecc:0:b0:4a2:2ed2:9400 with SMTP id p12-20020ac24ecc000000b004a22ed29400mr10307543lfr.432.1667410226634;
        Wed, 02 Nov 2022 10:30:26 -0700 (PDT)
Received: from pc636 (host-90-235-23-76.mobileonline.telia.com. [90.235.23.76])
        by smtp.gmail.com with ESMTPSA id r4-20020ac25f84000000b004a26debaf1fsm2070219lfe.117.2022.11.02.10.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:30:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 2 Nov 2022 18:30:24 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2KpMFrtwG+D4YRB@pc636>
References: <20221029132856.3752018-1-joel@joelfernandes.org>
 <Y2JkoVV3jaVS4y0Q@pc636>
 <CAEXW_YRZO086TUJCFzuGpAWRpQ-uKD1S5wDipJ9hR9=XddNFSw@mail.gmail.com>
 <20221102163544.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2KnxKDebPKiqTFZ@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2KnxKDebPKiqTFZ@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> to wait for a GP. Or if the poll_state_synchronize_rcu(oldstate)) != 0
> queue_rcu_work().
> 
A small fix. If poll_state_synchronize_rcu(oldstate)) == 0 then
queue_rcu_work() since a GP is still in progress.
