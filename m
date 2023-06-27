Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960667405A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjF0VeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjF0VeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:34:04 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B832212B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:34:03 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34570ed4cb8so17174655ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687901642; x=1690493642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZqYumP33fV5BVUZmpS7A28a1sWnVNycuG2BlU8AmM8=;
        b=IpkCBsUmZFPGJXzJ1xZcAyhntxXHhDd/LJrQddo689e29JvNh+T8rCjTy7OE937xh8
         VEEiIMNUIle8GoiLJw9as4dQXIf/KH7BrTRBZqPKwBpOVPrjrKvBvFvpeTMlXWPIf1KN
         QlNbuFsRWM1QaulTv8eWXnRrJ5sH6ZBOg2SaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901642; x=1690493642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZqYumP33fV5BVUZmpS7A28a1sWnVNycuG2BlU8AmM8=;
        b=G1epI0PML5TDxsN79FxG5wUUCxnvE/2Ww/863qGD7i0oxs74KdFKm64ix/z04U98ZA
         olrz9eIBgG11lKBeG8TwS6xVjyIDYeNT7ZgAeE0AoTnv+Kcfn3nqdCRr1juquUyS8uBs
         wn4xDfuqYZZuuba2mU+Bwbh/0olS3mA0pcijif5T6OGD/wvu2p5Fzj2yZvDv/9WRzF4Z
         A1xo/4owgPhWJcDLrUHcw0X5EwZwqAr3+lKJvbxNTGiZAjBXpPmb8JU5MbSBdxdCQmy6
         fV5wfYuXnKWLLOL9LZdx+iQlfjUKUV08oaQCgFM0gjmqQJjOY81UqtCdqOOF5HGuxWIg
         clIg==
X-Gm-Message-State: AC+VfDxxLJWFfxXH/kNPgwgwKFNElP07y8/ytu3dQ/j6bDJ//qO20xwA
        TF0lCNJ/SpCfBFmeL0n6a8wZi+tFf0smnHpNtKo=
X-Google-Smtp-Source: ACHHUZ7ItMgqKAmuFElauXWeEhfMACuB7n5OgXQznjB8sLC8WMB+/S8XZtmBgtnccaxreLuSg38DKQ==
X-Received: by 2002:a92:cd06:0:b0:345:bc24:7c75 with SMTP id z6-20020a92cd06000000b00345bc247c75mr2301923iln.9.1687901642456;
        Tue, 27 Jun 2023 14:34:02 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id d8-20020a92d788000000b0034233fd80d3sm2907859iln.22.2023.06.27.14.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:34:01 -0700 (PDT)
Date:   Tue, 27 Jun 2023 21:33:54 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/3] usb: misc: onboard-hub: support multiple power
 supplies
Message-ID: <ZJtVwqJaXmSPY3TK@google.com>
References: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
 <20230620-hx3-v7-1-f79b4b22a1bf@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230620-hx3-v7-1-f79b4b22a1bf@skidata.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 09:28:12AM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> As some of the onboard hubs require multiple power supplies, provide the
> environment to support them.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

Acked-by: Matthias Kaehlcke <mka@chromium.org>
