Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F35709291
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjESJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjESJER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:04:17 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8857171C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:03:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5617d793160so40676537b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684487023; x=1687079023;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=au2l+FyvETNQzq7cbXehMFIchBuXXNuvUUZ6G209oL4=;
        b=Er0lKlFEObxrGmwMjp+1ig+xRe1528XCOAO47idTNbfj4sONOpUdxSRmBhEAUpOztN
         75pDSJNBuGY9jMUYDHSbxEV8wxZmD+y7u9qWgoj94xA7y4MwD0G+aH8WfJR9/JtzRKQ6
         bh69zOweAtXHMSlzbVk3egREZ9Iwp1NJ1xh/qn1FGmCAqh1AyJu0tMF6D2X34+OcSiJH
         8MsfynEoxgtK4w/zJK5eCkuFnkhPfqDNnIcpiRHl9E3/UqaG9KEOpa0KjndA6qficTon
         BIKeDpaxRq0WCcQOiMp9l6yBmRzKToVmM7aBRfvdr4XkfgE/otFWXhDDgYUujmVFooYN
         1C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684487023; x=1687079023;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=au2l+FyvETNQzq7cbXehMFIchBuXXNuvUUZ6G209oL4=;
        b=ksXkPY7UZIps278ZAd89wAg1x9IAlp4ovrAbIRiXkeGSmaYSbrHwUeWS0+Ri37go5E
         a04vBGts06eWgFXcgoyhyzDXYZ8avZeOAHp+/tyLsZ7cip32GkehIDMlZ881KPGlxZga
         QxIdMC2RqtE0IKhz9K6qwC1Jq667VZ2wasQn9/roEorJmgIpZiw4dsGjlUvI+Te0ztjw
         a9e6tvFyR+w081JwcwNlFYZalal50MUytbN3lwu1eCid2ozZ1lGUrL20MEPtOIaTHGt/
         jX3bJM0PIQFfnZxvCo8JQISWpqMCy15sOKrWfnuXeo7olwS3GZaO4Btk/rITnSn2pE39
         dMAQ==
X-Gm-Message-State: AC+VfDxZOqnCKrHq5276aKDbEusb9goKwJ5h19yKHzAfrteT38acjRsZ
        EKKDSy3uxYOiGO6fIplzYzf5s0lG2LG7jCe1LtA=
X-Google-Smtp-Source: ACHHUZ6GRHJwX4bYhM1lEZfs5QyHDqjFm2ksFNisxX+9QCaNKqYKG+TJkLoEgpnkJ1hUezxwHygOfG0E/OpT66im9d8=
X-Received: by 2002:a25:adc3:0:b0:ba8:1887:8202 with SMTP id
 d3-20020a25adc3000000b00ba818878202mr1028304ybe.28.1684487023485; Fri, 19 May
 2023 02:03:43 -0700 (PDT)
MIME-Version: 1.0
Reply-To: johv19344@gmail.com
Sender: ismahalidu11@gmail.com
Received: by 2002:a05:7010:3486:b0:358:1418:8594 with HTTP; Fri, 19 May 2023
 02:03:43 -0700 (PDT)
From:   Van Der Kuil Johannes <johv1934@gmail.com>
Date:   Fri, 19 May 2023 09:03:43 +0000
X-Google-Sender-Auth: fEgjBTVO5aiXymQTo1L0qNAyl9M
Message-ID: <CA+cLWFCGDFZMwV69QWi4ULCOH+DqaqxK3JQcGVXJqr37dg=3xg@mail.gmail.com>
Subject: Are you ready?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you?  My name is Van Der Kuil Johannes Gerhardus Maria.

I am a lawyer from the Netherlands who reside in Belgium and I am
working on the donation file of my client, Mr. Bartos Pierre
Nationality of Belgium.

I would like to know if you will accept my client's donation Mr. Bartos Pierre?
