Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF466D577
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjAQEzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjAQEy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:54:58 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FD26863
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:54:53 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz11so8227539ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9OtDfatTdiphdlWN7zsS/2P0Fjf45auQYVLd+4H5vo=;
        b=gimqHc8M7ZiTlmeSjXy0PapfmZZJXx/aEvQUf3qW6K+GWhNnfWfXo/jTXP3XZh5jWp
         P7d/Dnj/33Os5Gt2jB3eDWegxT9PizNZEqjzd2hxMuYXgBLkwNjyHcyGRLYoOxBcWlte
         5MLl50W4741bRqtTlGqrvuXX4uT1pZHeP2TIsF4GOp8FM6IFzQyagG+NyBbGh285Iz87
         rJy2RrD0OthEjGIUMBlrFkK3d7Y0NkN9U6TwgdzPRXgdCUJm3jc92oMPrZsyd2AmgO6B
         eDeLAK2uj15E9rGy4M9zvqzgiO7uzGV2iObKL4M4EOXvqUKwfjTcCD/dGHA+A3aiij7E
         itLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9OtDfatTdiphdlWN7zsS/2P0Fjf45auQYVLd+4H5vo=;
        b=jraRSR7y8jX0BXd3q6KPrPmZjX5cP8E9uXbgAxdQcA8s8WCwN49fGKtesBaEe4oRma
         W85eiH7RSoFABtrgFcsE/1cceamMUpMgD/vHd8qzBS2TEC0vhcg3cF+C1GBoCccDM/on
         fVKuwXDqEFq8Ny3pxbwV3lZnoL5rN5okb1sFlE7mxhbrNUJHJLtmz/6xXmlMmPrbuOZS
         0fNqOa1XOO9qNx06iW5Ad4dmTicT2OcX8yhaSWerYgVjBEJgTWuIkvaGyy5Zk3yqBdMn
         yd1Q7ReNpHifxCAO/ye8y3D5zhOsq+0qM8nedpOT5c51zMfglp+rRpGIqwRWhJ2sAie+
         5rqQ==
X-Gm-Message-State: AFqh2koxbMCd5MiUamLv1Wrp5Q+h4P0bd7dvNMRKOWivJH8d+nJ72Jq5
        y+5z9QTNXa+/nfzgOJYS8Wl/gAGQrwSWcN3o3Es=
X-Google-Smtp-Source: AMrXdXu8L44QJ/mF3L+vVSyhyJrMIXToKWOTVrjKiLj5Dxuo0J2Y5+rU12noTveRV18MvoWkZgl9judrPhM3qcKLCP0=
X-Received: by 2002:a17:907:9870:b0:78d:b37c:83d9 with SMTP id
 ko16-20020a170907987000b0078db37c83d9mr87367ejc.637.1673931292426; Mon, 16
 Jan 2023 20:54:52 -0800 (PST)
MIME-Version: 1.0
Sender: paanhamzi178@gmail.com
Received: by 2002:a50:3a90:0:b0:1e9:af11:fe20 with HTTP; Mon, 16 Jan 2023
 20:54:51 -0800 (PST)
From:   Kossi Hamzer <kossi.hamzer@gmail.com>
Date:   Tue, 17 Jan 2023 04:54:51 +0000
X-Google-Sender-Auth: i7nHWLBU7O46728Ez5dEa_27XSA
Message-ID: <CA+gcyoU-TcJX6_DKEc4HT-0Z5J3npFYDEdOswbP=pc39Ly1wDw@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hallo
Haben Sie meine vorherige E-Mail erhalten?
