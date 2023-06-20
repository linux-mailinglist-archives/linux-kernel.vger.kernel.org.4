Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685787375AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjFTULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFTULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:11:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB6BDD;
        Tue, 20 Jun 2023 13:11:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so55153055e9.3;
        Tue, 20 Jun 2023 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291897; x=1689883897;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k7280ySvJLzpl43/DLWnMpsKHQLp4Wr9PaaleZmzRQk=;
        b=RvAUpk4WkHcYACUhR+KvTSE/xWy3fREo8WuJjgIFFiXcaq4tVWUd8UT1Psk53e3IP+
         Ys+03WlRrHnWoKnREeoSEmP4XjFEZKB30y9nqpVUU9kj2+vbjTTarox5KBJy8nLFcBCe
         4BL5Y0j9ltIBGfMoEo8r3iDFefUjqkMch/2XWWdtCIVJ8HlUOpyFsYsHR9ke37cAPGiO
         zy616Ffkly0/ADeDzJm84Teu4qxfBpLUN4hRf35wuzHS+5s83lUx2NjrnoPtDXpT8X/W
         FBxAkHk1zzNt5LdjY1ApYpebLMq5vS5aqS+xx2fCynTodfe4eDT+LP0H/yGAq+mOjpXb
         r1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291897; x=1689883897;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7280ySvJLzpl43/DLWnMpsKHQLp4Wr9PaaleZmzRQk=;
        b=Ct2Km9vmfBtR4izbJYNmFk5NP9Wxu4TM8bcFzTnB7SxN7YMdKtrJ8deJNSSzbX4HTU
         owuWvcCfE2jiq1tj0FfD0IJrNaGU8/T3MqzEyrjLcHuxDM9cZ+hnI0td4mUpu2ZCZv3c
         bKgerdW69aJVNhveenMB61vxUJ5bBiVGUSm1IDCd2bU/ZJUSoyiHw5XE4LJoFM+PQcfO
         dduqETTR/IiRiqXhiijjIRh3oIPBvTElN4Miw33x9DMOsBYq8TPVGmXJCIogH592tBd0
         4+7+ytl4JiUoJ7CDn6Pwz6NeMHNOTlAZHuRKWeRSYYaLg/JbSmethE9wx7Ydrj7ifPZ9
         CNtQ==
X-Gm-Message-State: AC+VfDx3o8xWygwrqRKpeYLNOluEBrpskccH7xfFXbbUJr7XGfjks5AJ
        tpOK7C3IRd44Cj9FE5/9tr4=
X-Google-Smtp-Source: ACHHUZ4LTwPuDBIisgTr67pUp07K3zaFGUKpyEBq06OZvNh1E/7CCBpVEApYzGjni8ZAUSy1DEfqXQ==
X-Received: by 2002:a05:600c:2285:b0:3f9:bc04:2245 with SMTP id 5-20020a05600c228500b003f9bc042245mr399006wmf.39.1687291897144;
        Tue, 20 Jun 2023 13:11:37 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id l20-20020a1ced14000000b003f9b19caabesm3095126wmh.37.2023.06.20.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:11:36 -0700 (PDT)
Message-ID: <649207f8.1c0a0220.86856.8798@mx.google.com>
X-Google-Original-Message-ID: <ZJGMEYSxIbQJ90Yr@Ansuel-xps.>
Date:   Tue, 20 Jun 2023 13:22:57 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for
 port_change_master
References: <20230620063747.19175-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620063747.19175-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 08:37:47AM +0200, Christian Marangi wrote:
> Add support for port_change_master to permit assigning an alternative
> CPU port if the switch have both CPU port connected or create a LAG on
> both CPU port and assign the LAG as DSA master.
> 
> On port change master request, we check if the master is a LAG.
> With LAG we compose the cpu_port_mask with the CPU port in the LAG, if
> master is a simple dsa_port, we derive the index.
> 
> Finally we apply the new cpu_port_mask to the LOOKUP MEMBER to permit
> the port to receive packet by the new CPU port setup for the port and
> we reenable the target port previously disabled.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 54 ++++++++++++++++++++++++++++++++
>  drivers/net/dsa/qca/qca8k.h      |  1 +
>  2 files changed, 55 insertions(+)
>

Please ignore I notice some problem and I have to test this further.

