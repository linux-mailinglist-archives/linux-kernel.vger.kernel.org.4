Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E860C71347B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjE0Lc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjE0Lcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:32:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E47E6C;
        Sat, 27 May 2023 04:32:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso1006702f8f.1;
        Sat, 27 May 2023 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685187091; x=1687779091;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wYajkNuX8Hbg8IcsyCxMpoTbxiXIDR0EfKBBYj/8kIE=;
        b=FDU5tQP0yjDzBMUsQ1M1f83eGrsShEyDyikhkYYfSVFv989xrozghxuxZQ1L5vFbUY
         AFaMDUm3p4noQFm0gWQ3LGbzwWovkOtNC5OZZLTctcj122c1UI6LBZ6bGc7FjsTvT6xX
         yiOXPyZNnxesey9YUohfFEdRJA8rK7M2nZn8jB551vtLVNQVja+ecnQvgfnc2rJvVLWr
         BMXUtGlns5Iln3688v1OqBgQsMoei2ipStmUiCWNLFErp6Hy3qQV4GuUdd5Pk2hCN0Pf
         ex4GCt6jKc/MXCNHDTEPi6voFTdr9KqhbKNmVSpJlTh4BHEpFTnZzkKxm76pM5LaJlzB
         y4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685187091; x=1687779091;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYajkNuX8Hbg8IcsyCxMpoTbxiXIDR0EfKBBYj/8kIE=;
        b=fk/EFHII7ajZelX1UBS8/bmWGwxpwuAxPuU23tBfFixmMiosPSEUrPejAdONZeJYcM
         yuYWfXvpKoX39n8CuVGe78ejvTqI6rqksF7P8d2SJ8PQW1ZqQfAA98b4/vVE3RCqsLnE
         PVGhe6eiy7ZAvXqVkwFBSedxkviW2GmTXaexOn52zAidsDI1fOaqmnSzmmeffHkcl1Me
         R0vLfBkhIHC5NkKrlVE68smm1iRuU1lfi9uoaysTBT4iPYbXPzdCmmul1yhzpr3ROxzJ
         Lg+3hgvHThkhoarp5/naAh3wwR1V/CsrmNbPuwzWyLh5i7PK8ffNCz1Lpjnn2RLA1/fZ
         /EIg==
X-Gm-Message-State: AC+VfDxs+Z71DKqZjGtXrC5EsxsL8W/WQDc1fsywK9EazeP7wRPwnOhh
        V20tgY8lVNNILz8oNyvW1f4=
X-Google-Smtp-Source: ACHHUZ4bEB/ZTVukSFhNaTyFglb18DrqpVZ7nMC0lsEgDYk42eNZZj3gkiNbf4h8keqx//iLlloBLQ==
X-Received: by 2002:a5d:5506:0:b0:309:32d1:59d8 with SMTP id b6-20020a5d5506000000b0030932d159d8mr3908185wrv.64.1685187090701;
        Sat, 27 May 2023 04:31:30 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id e7-20020a056000194700b00307bc4e39e5sm7779189wry.117.2023.05.27.04.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 04:31:30 -0700 (PDT)
Message-ID: <6471ea12.050a0220.14fde.15f2@mx.google.com>
X-Google-Original-Message-ID: <ZHHqEOpB6MvrIERe@Ansuel-xps.>
Date:   Sat, 27 May 2023 13:31:28 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-leds@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 00/13] leds: introduce new LED hw control APIs
References: <20230525145401.27007-1-ansuelsmth@gmail.com>
 <20230525204338.3de1e95c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525204338.3de1e95c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 08:43:38PM -0700, Jakub Kicinski wrote:
> On Thu, 25 May 2023 16:53:48 +0200 Christian Marangi wrote:
> > This is based on top of branch ib-leds-netdev-v6.5 present here [1].
> 
> I merged that PR now, but you'll need to repost.
> Build bots don't read English (yet?) so posting patches which can't 
> be immediately applied is basically an RFC (and should be marked as
> such).

Hi, thanks for helping in this! The series already applied directly on
net-next but I sent v3 anyway rebased on latest commit from net-next
just to be sure.

-- 
	Ansuel
