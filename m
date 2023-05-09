Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2566FC190
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjEIIUX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEIIUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:20:21 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4038E1BDA;
        Tue,  9 May 2023 01:20:20 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-52160f75920so3735765a12.2;
        Tue, 09 May 2023 01:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620420; x=1686212420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qTzqMnjrt6zbPmG4+JUk/g20AsH6G2q+2n9c40Grzk=;
        b=lck8sUa/4bEIoMmqKK29+YqYvlP2uIrHQumB0MeolLNBPjqRVdR1JEVmbh6VYBGvcz
         Q4wdjiI0re+JeigZ12RwHpX+kqb0Ku5aZEchv0KkZJ9NokV6LS8KaHgq9ItqygEctL4J
         5ss9PYMGiTMWcqObJxRZhKGdCWzj0d3/LEP8PYXHBDGE+2qNWs8pYyRQdWD/l/QYa160
         uV/4ifChzaj0reiExNdusuF7ipOsxMGtOAgCiMWN8ZxpuYm47BMj0bUv9vGOOD6gOWUv
         UGhWD2hKjQh/XyTNgIhn5gjK6YrQ/5LXWwi96TWpMEP4jmdfuA6gpOusLmQwiHtTtXhG
         MvTQ==
X-Gm-Message-State: AC+VfDy6/jlu47p3yJL3gKKHGCgRQFHn95+s8clZefwlCQwGhOFRtnpS
        g/fOkiTXv1BXNRd9ajOfsinvNp40dYRi0zrw7pM=
X-Google-Smtp-Source: ACHHUZ7ldxVYAuF9AUFDA+g3foA3ncVKVtFYaAwQTJHWMgXxuaN3Cty9BXzywClJfcb9Y90q1gFWFWVRXZyIjuxeCkI=
X-Received: by 2002:a17:90b:1992:b0:24e:55c3:89af with SMTP id
 mv18-20020a17090b199200b0024e55c389afmr13294479pjb.18.1683620419591; Tue, 09
 May 2023 01:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230509073821.25289-1-peter_hong@fintek.com.tw>
In-Reply-To: <20230509073821.25289-1-peter_hong@fintek.com.tw>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 May 2023 17:20:08 +0900
Message-ID: <CAMZ6RqKXmJ0gBMOh2yXN-r3SqX43eUhvQTXcvPzzsQSCHYtXhA@mail.gmail.com>
Subject: Re: [PATCH V7] can: usb: f81604: add Fintek F81604 support
To:     "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        michal.swiatkowski@linux.intel.com, Steen.Hegelund@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, frank.jungclaus@esd.eu,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, hpeter+linux_kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue. 9 May 2023 à 16:47, Ji-Ze Hong (Peter Hong)
<peter_hong@fintek.com.tw> wrote:
> This patch adds support for Fintek USB to 2CAN controller.
>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

Thank you for your hard work to address all comments.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
