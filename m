Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C070DD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjEWNP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbjEWNPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:15:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13A109;
        Tue, 23 May 2023 06:15:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae454844edso51648465ad.1;
        Tue, 23 May 2023 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684847718; x=1687439718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xAthNGXLDTLFcaxsW4zu97G9PTQI3Egsf4QBteoBFtY=;
        b=k54tFE0GkEBjf/zrY3JjRi8VDYwp8E+3GAYXupXplX8za+1IayFvBWHCVbDls837R+
         JNq0uAXf2GbEMmI9RxqmH8HtLETJDEeBh6QXsA6HoBXk2qOEvpadkkOJBl/qxmOCKEdo
         YmdZrBqosWNTYEJ/HlDuNfk1hoaZIaycuUroLWYqQe6uLMeg4zOtKvpo4Wd9YWtWAm5I
         sIWb9GuOWxgUizztqM90e5Pz9zbz6HK2wwgflPtGTQ4E59qlAag5w7r0sFWvbETAAnNa
         nD26tG9kIFWyG0vtOyccW1xmppO8PddX9mnat6kN4lIh8030qSQijHYbR91uD6QZc3+Z
         ulWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684847718; x=1687439718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAthNGXLDTLFcaxsW4zu97G9PTQI3Egsf4QBteoBFtY=;
        b=b9rvqgW08OaokIDhsSpwpGXkN6m963Zm8D2JpBB20BEpjQL21/vjN77kEx/TzlO7R4
         68bzyYd8yv+edsOYHV68FFAGFLWgRqzsk98QRAtECg3yNcKRvN/rXQ5rbSjvVtcJMAnh
         VqDm4xvw96EUF4VSVkCrzlNUSssltT+TSo/A5DldJqleRAfv3VAkOp6fHIF9pqXCB8yH
         CVq5/kN8tXQqzAUTrlGKu+ezhoiD0PK140a/cLL/hWGtdNlV88PFYWeQJLkpfAt4fLQm
         j1ywVoOpV46UUdcg92/JqiQa7mO9aV/xFrWk+1RZ4iYNirzKbJXWEt2HjBSDBteLKgs9
         SmzQ==
X-Gm-Message-State: AC+VfDzUuUFDN2iFs10InOPlv77f6Ojeow0N7QVGD7LuFFkLn4ItvE88
        EVejV2Gaeyw64ZAGouR9QRWhlbzcM7aSnv6ZETnH7XQ9e3Av7UQZ
X-Google-Smtp-Source: ACHHUZ7KTF9oE7T8/4WiMrCIodaYHqKpBC3WJusdH6hQSHqcdXqYltDBhbMGd2WupaCMpxDTB9gubLMUzaAPwetXRQ8=
X-Received: by 2002:a17:903:1247:b0:1ae:8b4b:327d with SMTP id
 u7-20020a170903124700b001ae8b4b327dmr15537129plh.42.1684847717661; Tue, 23
 May 2023 06:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230519142456.2588145-1-pavacic.p@gmail.com> <c0932a06-175c-3294-98ec-b26e961e34c1@linaro.org>
In-Reply-To: <c0932a06-175c-3294-98ec-b26e961e34c1@linaro.org>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Tue, 23 May 2023 15:15:06 +0200
Message-ID: <CAO9szn3gnX62OPHp66Mm74BAOe5UCG1kOS7xub682RU7aozC0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/panel: add fannal c3004 panel
To:     neil.armstrong@linaro.org
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

pon, 22. svi 2023. u 10:55 <neil.armstrong@linaro.org> napisao je:
>
> On 19/05/2023 16:24, Paulo Pavacic wrote:
> > Fannal C3004 is a 2 lane MIPI DSI 480x800 panel which requires initialization with DSI DCS commands. After some commands delay is required.
>
> By curiosity, on which board is this panel used ?
>
We are using custom board with IMX8MM.
> Neil

Paulo
