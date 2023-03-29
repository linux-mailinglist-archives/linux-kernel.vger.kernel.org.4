Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA66CD6C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjC2Jqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjC2Jqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:46:35 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D499B;
        Wed, 29 Mar 2023 02:46:34 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536af432ee5so283582197b3.0;
        Wed, 29 Mar 2023 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680083194;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kj7MeokRnnz1WX6SGf7aj7a40IFSejhm4QHlJ3A35GM=;
        b=LA1BPPTHjMvyenLtuyu/PWIE/HA8vfNmsk6yOQMM1VhqOvIlQ5hcShDH4qm4QXttNZ
         B32f3UtdkuD/VEko2VX5Yir4LTwKpLQcYcByKDnfOYnwn3PfoO7/nX8Ik35b5ctUlcgd
         zA0V7ceZIw5kOO/XU71iRPJ2cPXr0iCWxvgmGdKzyuyqxJljA9XiiTG+jz10xnPxBe2r
         /mlYH9Zbha4Wmdmz8TKd+/CKPEE1jOOFm5WQLBDM62+BczftHPycdKJNlVsbF9wHz8XK
         FrP7Z5DEvMcVMyqmwpESOxPfyMCNhvM9nQNl43ILM+IPquYjnO5aT3+H5Q2QVUb0MbpR
         g8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083194;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kj7MeokRnnz1WX6SGf7aj7a40IFSejhm4QHlJ3A35GM=;
        b=ANcRT3/IPB73jNB1RPUEhvuhyLn8d03fjSVjcbYVxjjC0fqNwCyuH0PzGv0GEU3yes
         idcwdo60Jjgc9wL6eB/atZloD6SwrdThl2pgN25vkQF/ur8MFSzxuFwWAogrht2cYtjh
         6pSR72OIheYEpckMtJxidN4G/oTJX/LcYFDTjmpnk/8fTUpcS1lKZAf2u0wYNENVMVvP
         6b2ysEOxVTZo0cxqxUEndnYtzgEvTXmQBgIFkc8oNG2cl/IzHJ7DYntnq9fFCvzeXSXq
         tKNA7y5gZpCIf4zcrFFEgLT3ehqrc6wbEc9WRHgmuBSp2RO2EtS+3I2+03XBFcSqVyB4
         oAVw==
X-Gm-Message-State: AAQBX9fbrf8Fe2wFgeOPANuWP47X/66Hd3qw2BTDCkSt/ZO1/16n78ek
        6z2eL6rlNM8BL4KZa8alxUA5PA6zlpbUxutt4XQQTOG5aUw=
X-Google-Smtp-Source: AKy350Y5VTroxzy08tTDA5f+Zwuhv4abQObF+tQGnVifOW8gzkrFJaRg0U48Y557VV+lw+YVIXA33PkdUuaJNQ3dH68=
X-Received: by 2002:a81:b28a:0:b0:544:5fc7:f01f with SMTP id
 q132-20020a81b28a000000b005445fc7f01fmr8872545ywh.4.1680083193744; Wed, 29
 Mar 2023 02:46:33 -0700 (PDT)
MIME-Version: 1.0
From:   Askar Safin <safinaskar@gmail.com>
Date:   Wed, 29 Mar 2023 12:45:57 +0300
Message-ID: <CAPnZJGAjE09M7a3WVrVA5LFiaw7iUixJPpaMQ6=bdmjvanWqKw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: add system-state document to admin-guide
To:     skhan@linuxfoundation.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +You can get the same information from /proc.modules::

It seems you meant /proc/modules

-- 
Askar Safin
