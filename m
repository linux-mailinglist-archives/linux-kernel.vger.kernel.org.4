Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8797869EC47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjBVBRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:17:18 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE752CC5E;
        Tue, 21 Feb 2023 17:17:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id eg37so20523367edb.12;
        Tue, 21 Feb 2023 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gT5ZSNIpI/yGjRCiyO4SCf25/TIbnWrvagpIK4outfk=;
        b=GqrAlrvDzA2RyHnVeA3Sjo6RvBiHGY5GTdpeagHbSMILyqfK7KUgYsA4MvEc51TaAJ
         cTaPbgN7CAVHFn9e+Ont7H2L2pb9JH0UO3zXX77atqPW1/ncQQ2mZc+WYeyV0X6ArmYE
         Mrq+qH1vBEnhEaEmuxAANgQxRHzzgjKe39XSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT5ZSNIpI/yGjRCiyO4SCf25/TIbnWrvagpIK4outfk=;
        b=jiapD0Q6Kw+dvK2WAc4TrfYBvec8DXp+jYBJbSlR97Wx+wcmpwCriE8CdoctFUXqQT
         2jHTvut3OPGCahZdCB+73r51FXfV5L4xL8ns60PC7rJMGqCTQl0RG8U1S/uIb9gvRQ89
         +iZtnY9igHSlZWW+tKJGMxvYEW4D9h0foVXCvR2Sq44Tzu6Uv72izunfCcRK+jSSR46y
         B3MplgzeqZL4j7EA1aOejYkkdO7q2WJjsc8mJayc2203LRrH1vRA1OeIZ9ZSSCz0XgZi
         xN4srvL/5pNC/+he62UQu/ZJ38vWleGl9+LIuCoKHnXXJ81MdVaTR5rTsLfoAgChpM3V
         EGiA==
X-Gm-Message-State: AO0yUKVR5WCyGBDLe7LXBhRhlUFqv0IrLA34UvjuKa2P+jpk7AlLxaPJ
        cSDPleK+OgxdpQBbHqEjI6hAxuLhE5HjhxttwvI=
X-Google-Smtp-Source: AK7set9exesMePic266XNZcQh4feMCxFbPgJgTLHbhqLICr+GjcL5odlL/ZqdseIwc2ukLyyBshlOXwGx6djDfoQtn8=
X-Received: by 2002:a17:906:8295:b0:8b1:3357:b16b with SMTP id
 h21-20020a170906829500b008b13357b16bmr6714865ejx.4.1677028635979; Tue, 21 Feb
 2023 17:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20221118065109.2339066-1-quan@os.amperecomputing.com> <32FE8D60-98AF-4134-8FB0-46B0CE7CA420@amperemail.onmicrosoft.com>
In-Reply-To: <32FE8D60-98AF-4134-8FB0-46B0CE7CA420@amperemail.onmicrosoft.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Feb 2023 01:17:03 +0000
Message-ID: <CACPK8Xe062i-6RsF6m+G4W8TfVVh=xOpmSevP2qvPy=u1_UqzA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: mtjade: Add SMPro nodes
To:     Thang Nguyen OS <thang@amperemail.onmicrosoft.com>
Cc:     Quan Nguyen OS <quan@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Open Source Submission <patches@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 at 04:02, Thang Nguyen OS
<thang@amperemail.onmicrosoft.com> wrote:

> Hi Joel,
> Can you also pick https://git.kernel.org/pub/scm/linux/kernel/git/next/li=
nux-next.git/commit/?id=3D7c07553807c5125c89de242d35c10c206fd8e6bb to fix U=
SB gadget issue? It is to support multiple devices (i.e. virtual media, USB=
 Ethernet, =E2=80=A6) at the same time?

This is also in dev-6.1 already.

Thanks for getting your changes upstream!

Cheers,

Joel
