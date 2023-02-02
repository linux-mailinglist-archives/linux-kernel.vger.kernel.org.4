Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA48A687475
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBBEjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBBEji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:39:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F80F5EF85
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:39:38 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 141so514343pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 20:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UuI1e5Nc5nxg3sS8gW98gfCshv5JM9kZz6/Ac4KvGpY=;
        b=Tl0PCNROkqivudpZ8md8tBCcOrFX3lLHG7YlcQfpqdJOSDRWY1Zdwb6+SPs9wHFmod
         HC0iS97xUJZHmvkvVSMT/Gbl5d0UTX63zmwrZ9755IOA0HzQ0QO9xElD26SkH/TWI+Ws
         kwOmZv8fT42k0LS2DsrXi5zbCuZVp6O6G9c9ARnx1cyhgnf3VGZWLKpjyOFWjL2HH4C0
         7si/HHrS9QG+laSmItmgm9tMpC4r5G2kO6fhnfthhMzueiXKD26uwEgvOCaa8ST6v7lq
         SzX7PHv+ZRyKw2dLJhuq+oDJo0vN/sqfZp/jyL/jaUew6GJM9BgWqhkEXXWtMQapur7I
         SM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuI1e5Nc5nxg3sS8gW98gfCshv5JM9kZz6/Ac4KvGpY=;
        b=Ml6XnBBqY0X9HI/WUgpmqxivwmfBaY6xwGKuQ57EwvAFUGB+DDXv3NKf+5Caks+P5Z
         ejuw4iQ+bvxD5QUCUibdJQIX/iLdBlP2n8cGnl4u0/JjtKWjOlteL3YD/suKfPS73maV
         +EINfkBsTCY6kLCtMDI3GxHwDfzPq8VGhpcEIHrku5bxqWL9jCFjy70A5vge3OM9ETNI
         DZ1cIsWmZf8TndUeR3JF5fclizvoyHrX34RakTkkyid2VXrIrG9AyWdIobY4xSsg9mls
         cegkPLCfhR/BhdYG18XARlyA652VQZA5AAl9Ih+CGTNa5QCIYwPoQP8cXGgyC+gUvfaf
         3X5Q==
X-Gm-Message-State: AO0yUKVrouNXj3yPfkNY2mAAitslGG7g/BwYXQMfMXVptS8oMrGrynkz
        MHO7eeS+0jTPJT15aKcyhQx6lXHjhfRc2b71G54=
X-Google-Smtp-Source: AK7set8NToH4Jza7TWpybH+atdmJXEW71ob4a5X5nb1ie28s0Iq1F6/6euNpg+IT/KuSB5Lvy1ncL/lREbNyade2Ye0=
X-Received: by 2002:a63:1941:0:b0:483:f80c:cdf3 with SMTP id
 1-20020a631941000000b00483f80ccdf3mr863062pgz.70.1675312777533; Wed, 01 Feb
 2023 20:39:37 -0800 (PST)
MIME-Version: 1.0
Reply-To: rifaatbacci@gmail.com
Sender: homurabba@gmail.com
Received: by 2002:a05:7300:2202:b0:96:2667:8e91 with HTTP; Wed, 1 Feb 2023
 20:39:36 -0800 (PST)
From:   Riaba <riifaatbaci@gmail.com>
Date:   Thu, 2 Feb 2023 05:39:36 +0100
X-Google-Sender-Auth: riRE42IJoPqeN1cOnvpJg6_HSs8
Message-ID: <CAFpiVOHhRg8mZZhsvwK87UiQOz3VU0wfcUJtGmK2-z7g+qAP8A@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

The letter I sent to you earlier, Please, it's very important we speak
and discuss the business proposal. Try and get back to me. I really
need your response as soon as possible

Rifaat.
