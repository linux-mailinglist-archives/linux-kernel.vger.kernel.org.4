Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976F272029D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjFBNHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjFBNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:07:09 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8351B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:07:07 -0700 (PDT)
Date:   Fri, 02 Jun 2023 13:06:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1685711222; x=1685970422;
        bh=2zdvXX4sYeWKlCPzwuI2ldQx5Q9lIBm5B7EVumLxyxA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Ow6g8D3nTM7Y5eXz9RDrc7s71FOrqB5aOeVVWJNi/WgghrzwH0wDcp2zZkcyKXO7Y
         oWN0hNYd1ghBmmj9RGUliLpiVPJIbVtiPn78jiqyIg5hQWLKXygQoPdepe4mk6F9yX
         p8ctqJWK3TmB1NVr2TkAowugVg+L2JrVdGV5OTV0jEdc5Yg9eu/zJ6dCl/SIX7FDx5
         3MxKQ6TBgsQmEGQjXSFnFbtCvpt6NRyQo+8ZTNCaFLsX/5nymgsX7g322t5LIKaOS8
         7Jc2a4oVg4B+bhz04MZNBurOZl0geK+wjKraYQU8VGg1JtltlSZktv/lo/pdZG1R2R
         eiN7OU0ZmfVTg==
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Raymond Hackley <raymondhackley@protonmail.com>
Subject: [PATCH 0/2] leds: sgm3140: Add richtek,rt5033-led compatible
Message-ID: <20230602130644.259933-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richtek's rt5033-led has pin configurations similar to sgm3140.
Add it to the compatable list.

