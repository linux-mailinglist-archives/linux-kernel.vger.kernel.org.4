Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37F621DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKHUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKHUqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:46:39 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB450CD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:46:30 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d20so14155025plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdU0l5q7SwDqyQdrl+AlHir8nP1WSQabvgknUb9WZQA=;
        b=KqpAWA/gDNnYa4LOJhen7UzlTjDJtcMLTXpEYMEeakVwVEgRG0ANaXVOTUks29L0+k
         ilg/SOISavl5h4XwYKKYasIcwbDx0y3XngNf5stMmbBG8YJub8f9B2V4Lzw8kF09rv4O
         aOqkI5ST5FC/XllrtTpuBOdxs5nVAYtrFxeHkLblQWmtdn0r3czVlN0OmSv2lvqZSW+c
         kXP7LR9KWh4rcqaSMNDqSc39LPX+RHOl2QMCX2g+g+qCdUUhXFgA2+RBEJ+AZzRQ41z+
         Saj2I7dzOvjdATSP289abDTIuxNW8/Dv5fUiqUralFgGL2X69lXU7yy31Nfx9dE6Cqmr
         j60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdU0l5q7SwDqyQdrl+AlHir8nP1WSQabvgknUb9WZQA=;
        b=fL7kGbytSqdmG8Ho1htl4teTLNdb0AoUEcg1w7isT3qRr5N11FfPdx+SPd52LZwOKp
         mYqXbUXKBYmqpziX8zKxDNw0fDikr3B6h9CC+KxAIgWqO4c3cp301iQsMV2eyItm1gZy
         5CVNC4ki8a9nLSBcAShOIuEJquFGEX0Q0gWNAzXGOcfK19KT/s9G+WV/+vRqabq3RqQN
         7LDrXVJpM3Tnpb7UIPnKgqEUPPTblxpZP9ci9LWVWiefihqSezElDSzzrJh+efxDotxc
         49zHrQio5Gr2XdHW7v1ZfMAkFIcEIuZRd78cz2V7DLTqRUkuDwVpUQUNDJr8w+mXXst0
         /Cmg==
X-Gm-Message-State: ACrzQf2xrgunksfIw7/CvTHtwpUmA0VPJ+IR3H5Rbgl5rLI+1qHOGd12
        Jj9M8AQB0hZKJIPYKz4bqJjN6hUgL2WPkOPnS5g=
X-Google-Smtp-Source: AMsMyM6mOT7t1+LOQmdblzd1OzDXepP2PBuECcWZmEtDMnducXOHOG4OQSYz3oXJerOnxUL0K+quJyk0mp67IG0dix4=
X-Received: by 2002:a17:90b:4ac6:b0:213:ef82:b111 with SMTP id
 mh6-20020a17090b4ac600b00213ef82b111mr46572382pjb.170.1667940390475; Tue, 08
 Nov 2022 12:46:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a06:319a:b0:57d:af60:aa53 with HTTP; Tue, 8 Nov 2022
 12:46:29 -0800 (PST)
From:   Ved Manish <vedm60013@gmail.com>
Date:   Tue, 8 Nov 2022 21:46:29 +0100
Message-ID: <CAGwWHSQTG2iMKbz7GUxu4TcZSAVRA6_jkc2ko0GKZGUJC0e5hw@mail.gmail.com>
Subject: New message
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
Did you receive my mail yesterday?
