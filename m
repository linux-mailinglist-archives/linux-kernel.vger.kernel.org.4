Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C85BB1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIPSR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIPSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:17:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA2B6D27
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:17:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l14so51315856eja.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=VVtE7+536yYTPz5uirtjqrhsMolSqt/MqYYSiS23CA0=;
        b=GJQi6TVo2+aiHf7uPZbTC5aUNZJBP/I5PT7oXHzRbwnwIGTtfSXCJSJXPDOiZj41mj
         /yfi8Mi1ninkxPfSXq8QiotTwyj0kkK2/Oiy7I3ETz2wSPrb/yVCWvuWXEabSW8m5AnD
         NLawTVeTIrGuQMLhs1bRgR17JZkg2dt34Gwx2wDXVilgdXpO8pPmuQ3dOYLigXKKkq3P
         xIbRfguyDIHw3GF7GWtD6P+39QskJ7fnftxu1MhBVjk2IsT7aWZsCvL44cJaRxoOC2y0
         SJz6BAUXxjgoehsILVIzsmtvT0DghWxxqi8g25qPvSFXjKn0h7rpV/v+PpOJwZ6mqE3Z
         8L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VVtE7+536yYTPz5uirtjqrhsMolSqt/MqYYSiS23CA0=;
        b=o9kVI+DeNdFCrAHTk394jo53lonv6Ck3SXEQKWprmDE4ZpdnAMq8X369D6rZIJbmuO
         cO0kAlb3TNyAxuS07xvow3R+nfBUZaCbOzHps1fLNi9E9jRppj5bHja1xLWBOKc1syqg
         cDBvOtZlLtvkdOWb/gbAv4ivMZWpOv0bZFCfBUn5YAG6TVi9PqFoldeFjBzO1zgUQBqm
         FrzkzNbbTT5pNCkiDfyBKPn/jFDuzMW+bL7NXHYbK2QAlPRyucpKanJ2WG0T9n5SsK6b
         7wtl6ri2xDttL3f6sK8pn4HxKmU+b/zcgPce1+L5PAuiITeIN5fRh0oKzupgnDu7hdOJ
         xdfQ==
X-Gm-Message-State: ACrzQf0JQDf69z6d/nDNfRFbJqXZtdjIXLFkuTgPme70d6902Xg0qpsI
        JRC2jUwLrgFZwzB02oeT+TkRueC0Wk/4ezP0oyg=
X-Google-Smtp-Source: AMsMyM4ITUCugFLQNmjay1NHU0X0neA4f2Ls9oClIdd8yPA1Zb457+WfYPMjP7LkY1+gtWy4kttTH8kvfKMJ3cIxcpw=
X-Received: by 2002:a17:907:7289:b0:780:2017:3898 with SMTP id
 dt9-20020a170907728900b0078020173898mr4493555ejc.276.1663352244568; Fri, 16
 Sep 2022 11:17:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2d50:0:0:0:0:0 with HTTP; Fri, 16 Sep 2022 11:17:24
 -0700 (PDT)
Reply-To: mr.hensley1960@gmail.com
From:   ED Hensley <offiec.tgg@gmail.com>
Date:   Fri, 16 Sep 2022 18:17:24 +0000
Message-ID: <CAPuhCHNc1Je-DaVDDAgSEMTSJxRQChVkS2Bx7EX9HcBu5pR-Eg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I instructed my Secretary to dispatch a parcel to you. Please
let me know if you received it.
