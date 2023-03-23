Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112936C742A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCWXiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCWXhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:37:54 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7FB241E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:37:48 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id h12-20020a4adccc000000b0053be0ab06ffso43363oou.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679614667;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=FvZOp+hCyaoDuoSw+eZr4NXBDOZqgAh15cOgTl3c36cfKyZsPSKQziFeHO2f9llY7Y
         4MgnraPTkpK2IOtcsK/nNMWXTbfiK6aa6YvE2dkW2QB/qT6hNPMQ0AtBbSUkelrslvUk
         AU7cKWKb5L0Zf//I1+9WINusgNxmBOUj+LlCWSdgMrXobEmz/UmIUamJoNkFxbodmrYl
         74YyDN0QXd8ThbnEjxAi7hVhpjADrgkLUuvmGtUTHmh7Mb40rA/hOLy48muHS1bCeXPW
         02lsXtkHWCBREuwIEUGcWnERJIJpGlHufX8usLXV8b9kqJ9NfVQhmv4XKQUS6gFtwHd6
         T7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679614667;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=il4SBJTObXgaZi8xQ3CV1IY4QhZu32VwrBfrkvZU1WqlOK7O9C9Of2OOVk2SIqep6q
         L+/JhqYGBiZYOjJgMRDJkxMlcBkAY7rctih7rwgYZAUPe20b/crRgfs31mebocoxENRf
         VqNCfi+QwC3IISkR+QhGgFlHtVRo8jeFDGsw93aXGuMYshN73Zf7Y5VLNFm1y1q7tILz
         X9c74wdzFDWjBUdwtAF7e6k0tvRuRGq+D+mw+EP1JMYwp/kpucZf9/EV6/ZUpe561xWC
         UL0HaT+w2i0pozECoNY2pEBwf84/2BrMdYNLEK0V2xZEfP4B47fsFRfBc11tzBfO4mmt
         azLw==
X-Gm-Message-State: AO0yUKUJemG7jFYYpgWX3HZ5ch5nHkgCgOdVr04iQCLIcYUnIpShFLC5
        NRQeSUETd7ZUEW3p5PgQlQi7ZINWmFA1A6rqWms=
X-Google-Smtp-Source: AK7set+a/Uz+PWD00/U4bj/JOlCOY7vIlvnZeZFyK+3FxLwD1R9bx2P1ITGTVY1hXaU506dmpNpzwJmq8+RkfZnopvI=
X-Received: by 2002:a4a:e5cf:0:b0:52e:17e2:7d4c with SMTP id
 r15-20020a4ae5cf000000b0052e17e27d4cmr471999oov.1.1679614667402; Thu, 23 Mar
 2023 16:37:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:9101:b0:104:b11c:c6ff with HTTP; Thu, 23 Mar 2023
 16:37:47 -0700 (PDT)
Reply-To: maryyalbert4@gmail.com
From:   Mary Albert <desouzabayi7@gmail.com>
Date:   Fri, 24 Mar 2023 00:37:47 +0100
Message-ID: <CADVjuPpX4Cj6kRkkLEZ=XLWfv6wf=y9rd5_jBAxJEi3fZ7YWoA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
