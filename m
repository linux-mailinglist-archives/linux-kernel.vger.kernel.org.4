Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543EF6F2BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjEACpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjEACpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:45:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3F10A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 19:45:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-958bb7731a9so425884566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682909099; x=1685501099;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk4nfCem3ECRa7Gml0J0mN/3RZoOAdfGaQAqyHPKtiI=;
        b=a+4nICYxuxxAPmAcYlxNXDydLylvoQm7dZMwAvvDKlG6yKcyDIpz9Xgn4azpAuQNhW
         SaQd4Cb8w/lwtKRTzBFzifXPAOdISNeUpLKnAcZTHhQlN1YWWcolk0wRzn8HXfMxvjQc
         rcweBT37LyfZXv+1wSMlmcugk3F+2Ajvm4uyD1vpkxZwAB9bX4z7yn90Z30oxhT+SOre
         MtwfqNpxavaH/GXVagGqqFVtvDyHTxCyhUFzwTq7rmnTssjRPDqfqsHY9JyaOVvW3Fzq
         oLI6HovuLvwfTS2FcZ0Cz3geaw/TMQD3fwHhcwZl7ShJmRE0SvqEb54w/9H19CWgIRKG
         wH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682909099; x=1685501099;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk4nfCem3ECRa7Gml0J0mN/3RZoOAdfGaQAqyHPKtiI=;
        b=dfDW8md7jWUrp80C1alDaVJJQMXTVeIvfjHIYnXpF5D+I3AqjX69g0FOQzM/NpfN6R
         lVQud3eKqPXamDx7HvE6BI3W37yNNU1GYwOsbIg6c0NkplXj/QSoVkOZ3Wd2/dg8b6FO
         GpsqFtbwLPxkmN75/wHQyhG80JUAlvVK4+SoEm9bXmif0QcQVGYYSOT1lUJWCWwD0fuq
         Gw6EJXgAyPaxeTAti9tHs/27udxELwlVAffIF3+v70e9ytTqA2GZUjSLCTI3qw+wLiss
         ihLveMDH0Vu+wC7vRdwiCb1kGT7YGwS2VMbGbxNm4yRVfV/39y10fd85h8zQPWceksQV
         vrNw==
X-Gm-Message-State: AC+VfDxxrnK1+tUYIT+XUDyK6+5WKdduZuujTSwAvs+IYtxB6/RhYUPv
        XXvoNbyTKkH8hbY0KjqH/yGH3aZqoTHh0zKpEeo=
X-Google-Smtp-Source: ACHHUZ6qRFB/ZhWGiUNVVj1dFKPMyYivOArY6iBWWGEBztcUjVgcIbgb/el5JikCBa5wbb+RAmoa0BbEvHqqj9SAmfI=
X-Received: by 2002:a17:907:961d:b0:94e:d951:d4e7 with SMTP id
 gb29-20020a170907961d00b0094ed951d4e7mr13686293ejc.59.1682909098738; Sun, 30
 Apr 2023 19:44:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:cd18:0:b0:506:90e2:2677 with HTTP; Sun, 30 Apr 2023
 19:44:58 -0700 (PDT)
Reply-To: johnwinery@online.ee
From:   johnwinery <bakeraudrey88@gmail.com>
Date:   Sun, 30 Apr 2023 19:44:58 -0700
Message-ID: <CAPJ=KJWDoQg6C1c6MV42ooGpgxrwzN8W7yW6x_kc35NwthbFww@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting ,I had written an earlier mail to you but without response
