Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230B769CFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjBTOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjBTOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:48:17 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F11BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:48:16 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id eg37so1835637edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmLoazRJEFxD+263hZdQQQeefNauOvT2QGG3PVCHTcc=;
        b=d7/6KyvCKk8GTGxyV4Cncg3g3/neFChGqYGfLhp2jG84oYaHZrBt6JDCzLGYVpjy+r
         zUhW/OPVPQQT07KOVEGV1OaMVe42Dg8QQiDjrWrg+WqTQ0k3ofygmzDpPQ88NPhhuS1q
         Pk3WJ9Um8XFiLKadWtT9riiAera82Vk7PP9Ky4Yi+jZiasqmHReTNmd1mm5DMy0Zr3Od
         t0atotK/4W+3FVAhUlD75saOb0zlK2L/6G1ALZDzZ+ZjCaXdLsd1Q46LDuOj43y8yxrS
         yppY9L2+NZ9WLliWr/b3Lq4uKKzzAGoU0WM0dHP+zBxZ/z6lnCBsfx+NEG0yZ3OLrQKm
         xIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmLoazRJEFxD+263hZdQQQeefNauOvT2QGG3PVCHTcc=;
        b=F1XhD3P3EfFSWG6Zlo3RwRJKrAh3W8HJg7BpgXdz58V33MNDkNjL791z4vgQprbKDM
         0dPJCbBVdhlIagKe1KYUmxYlanoTpf2AnlwlYjnZQJuZoNY/XLaJCXTWyudBRaDcmAcx
         agnhdWnPwKX62DzUbXH9y4NIiBYCEcwGtnrmazryVbJNDTFvbHs39LM63cuBpnTtubgY
         zQIGkM+4XTK8VY6iTJGPAmdRuka/lDH2DU9NndaRem542BvfTV7DEPVuQjHC2VbmfFfc
         Vy0VVgcErxGdNYQeJ/Rjo/N4Zd3niIugtJvYEx3d/aDZPCWFTHbNcm+LMsqUcqRh6vSP
         WA3A==
X-Gm-Message-State: AO0yUKW49K8cHScyTGQVxnYntnLvg+ljkyLL4gYS+6YBVNTXfYKBlh5r
        9S7iIS7GtcKEiCQLX+OKCxW7Lum7rl4kArJi77A=
X-Google-Smtp-Source: AK7set9H04clOLBrEfiNI/k1DNjWpNX0qEq91Og8/JPGOlbhYXKgo76oaru8LVatkEqV9u3NVY6wDxAV0PpKGgQP2D0=
X-Received: by 2002:a17:906:d9dc:b0:8af:373f:4731 with SMTP id
 qk28-20020a170906d9dc00b008af373f4731mr4438969ejb.11.1676904495045; Mon, 20
 Feb 2023 06:48:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:3708:0:b0:1f8:a875:1217 with HTTP; Mon, 20 Feb 2023
 06:48:14 -0800 (PST)
Reply-To: fiona.hill.usa@outlook.com
From:   Fiona Hill <goodd1807@gmail.com>
Date:   Mon, 20 Feb 2023 06:48:14 -0800
Message-ID: <CAMPS0kaYuOf=Wezh499W1iMCP3B2pVhGmPtwLCUeGUukCtoZUw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello did you see message i sent to you?
