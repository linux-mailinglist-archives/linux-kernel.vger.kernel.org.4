Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86BE63A514
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiK1Jaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiK1Ja1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:30:27 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9580B18E3E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:30:23 -0800 (PST)
Date:   Mon, 28 Nov 2022 09:30:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1669627820; x=1669887020;
        bh=7YoBzNpn8HKIEqf+GljIP7pMTP3BAzak4g4w5EjkCW8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=e6a0Q7kgfsIvwRrd7s0mNPezfQpbp4hVhdCqDnh7t8Bbs4uyrZedfPUiw4/x/fzlI
         ufQNrEHr0By4oYqkAm+bq6m/PNWqf0iFug+JjiLi2HKAB3S5T/cCE1Jo/VZJpyUaNV
         O3VnDLwk2PEpOyl+X/D1aE1tbMkAke7l8dglTV34mjjoaVli6qJkX4BJvJtE+9InQs
         J+36WETr//i2UuLRQ3JcJk+io6gDAcGH/Zcre4b6NW0QFBxyTEelDwkP1CwpFEnxVL
         ATm6rfZTjThM7rl4Hpa3fgzto02K5pkiaSQtXyXrf8DL4OvQJa7fsFwwgFrMHJlLPz
         ICxbR/Kb4vLfg==
To:     Pekka Paalanen <ppaalanen@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, contactshashanksharma@gmail.com,
        amaranath.somalapuram@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Rob Clark <robdclark@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Subject: Re: [PATCH v3 0/2] drm: Add GPU reset sysfs
Message-ID: <584UdQAqoPr4vSxCTJg70LFQm--HpHH-EhnAo78lRAZ89OnrDkUeKlTnDGT_DMzDT3PeEtmXNsrqB6GuiV4TsZv3pBU8kFWjyPLWGrevIMw=@emersion.fr>
In-Reply-To: <20221128112528.1206b1f5@eldfell>
References: <20221125175203.52481-1-andrealmeid@igalia.com> <20221128112528.1206b1f5@eldfell>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PID is racy, the user-space daemon could end up killing an
unrelated process=E2=80=A6 Is there any way we could use a pidfd instead?
