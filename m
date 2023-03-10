Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3496B4CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCJQUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCJQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:20:25 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6D5763F9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:16:04 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e82so5794595ybh.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678464952;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Tr3U3wkl/fhbS0q0tGYhcEKwUcoYH2nJmcGkupTLtU=;
        b=e9oNj/qGe4jQBcIhGtgH1w18Wk9cO8+vnWjawYn4HUWkS8gzT2p1uCTxD2MNZ4pm8n
         08Pw/U8DQ2UjpLLo7WbbxK7iAu9NxySyzTUC2RSeb685jyYrsNnY1um3H9kyQ0Rlxqka
         zc6a59KmRc0HB04OJSUc93uNwfIDXfu0ISyPLZvKFBysb2mhdGbD9cmBP6G/gFI5ZioQ
         he5ATYQJgyJgbfc0FsoT45Uflb74sDNZ0K+I9gzRR2Q5QRzbMS7I0QeIGuSiJIXz72dS
         KE5jISyVTRx3joa0RgqIiPl0YxQ3Z2GDXXXLcGFN+Dp9wt1pdtt9NugPwFOFxmqEPxfg
         zhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678464952;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Tr3U3wkl/fhbS0q0tGYhcEKwUcoYH2nJmcGkupTLtU=;
        b=G6xUQFAJkWuy/EJOYbA1FXmaXltuWDYSju7JfAB+MeHbBeHl00MboOnl7YNYWxmUi2
         isgTA5Mlr0ep/cYIgBxzPQLZTKBdYqXGm+hSe0Wi/AYdfJ2DHDol450/wkEcw606fRob
         X+eN218DJ3/qQrlgWWpNtfnBVn7flThUd7NH9aLXeBy+9Mnqcdr3vWzELYomqU+GviDh
         7o5A9ZeSpcog92hXIAPjk5z9bDEWgQfNipVQkeqYySLV0wCph/435PSesQ8dX5o9Qj24
         y5jAw20Jh3Wp7+1KF6bFiSgXGhyKEb0C0w/uXtx0UUNxgxXdjwtJrwPFoIIz34HIpONd
         5b+Q==
X-Gm-Message-State: AO0yUKV6HquLg+DXRvLO6cpTKvcW0vMA8KfUHqkb1BhNXXw4RzhVElbw
        a1zH+YTHgeFg5ZADhq1lpa/0E47XesbUSK3+lwM=
X-Google-Smtp-Source: AK7set8tz62D6RZ3scCBwl5AoaH84E6V/nmVTh+2eMuOrcMHIAWLsMOS5MZZlBQd1b7TtDxz7peTfx3cHSPR7GYGGmY=
X-Received: by 2002:a5b:384:0:b0:a65:8cd3:fc4 with SMTP id k4-20020a5b0384000000b00a658cd30fc4mr15828933ybp.5.1678464951994;
 Fri, 10 Mar 2023 08:15:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:360f:b0:1df:398:c28c with HTTP; Fri, 10 Mar 2023
 08:15:51 -0800 (PST)
Reply-To: adbahassan.mohammed@gmail.com
From:   Adba Hassan <enerst.nawnne22@gmail.com>
Date:   Fri, 10 Mar 2023 16:15:51 +0000
Message-ID: <CACFyLymRuGHXMXCySDDxYhJxOJzMY3POpAsAttffiwUFguP3Xg@mail.gmail.com>
Subject: from Mrs. Adba
To:     enerst.nawnne22@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Dear Friend,
Go through the documents carefully. Attached is all the related legal
documents from my late husband with the company where our family
inheritance has been deposited.
Regards,
Abda Hassan Mohammed
