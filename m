Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4506D43D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjDCLuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjDCLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:50:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD830F6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:50:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so19315612wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680522619;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWT+QpgzDiawgFvOzomE20UM8yCKCgnlg/Ii3CJcGg8=;
        b=pf6L7ohsA2TBFFKCeucVct8atRuIdGTIhI8jK+bOEL9MWtZs3Q0Xhbog06cZyXgqml
         +3EX1/iu4VFUjX2FX2ql0fsR4ZpZhBt4zsGuepa87IdvVKynNIGQaf9PETBR9h0zaM4g
         3W/YA9+HNmIscbRbk8KJwTTZ4ikDaPEeFsCB5UurYHAW/XXV+nRVzxC5QthspOqXVgdn
         1YOAG8PQUrVIFmkXQ4U2smElI+gwnGpAGTqPqkjjo6OL3S581S1l87wl+Da0PJEbqRUa
         mc99xSzUDGz3ZqDIZwGm1/QIeW4xtRT9ZNtI4NWVuqnhUqbyiXYleQcVuE9bett0hvgv
         bp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680522619;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWT+QpgzDiawgFvOzomE20UM8yCKCgnlg/Ii3CJcGg8=;
        b=tVxNfcSfI8Mp/+fAPvVCGszArj4ytnlSN3/Wg7FXtblFCC9QrOBk6TsVf1RWQlAxtW
         guRqRWDTQRQJPDCzdn4XmSUpTH4aw9TjY6nlygQIJCjxHsqAPs1Rvb8xWyJhJH9a/oJg
         QoUn2qJaqmM1vGg2/1j+XBAqhXzkIapzkDjRnnq851vIPNHpQdCEhH+ob2dzjFi4iv2Y
         DvWOHwCqUIoHriS39XxRE69Xp+xn3D1AJh8btxxKmBKRYLapY7c2kbsSGzGX3mc1eyes
         r/pMwHhaKqz8FZQjDY1cRy1W9bdQIZYD+eimawS3Wp31dtj6fh+CuZp8rgDUDUkCvPgO
         e7Qg==
X-Gm-Message-State: AO0yUKWnzBHC7UBpfXrCRFUezef7qKJY6FTqR0bOqxIBVVcTkX+Cu9pv
        hH34HBtHYtaps3/e2yjr70SPqGsj8pamvQnBYpM=
X-Google-Smtp-Source: AK7set8Gv5MLRgaZd8plDxA4DJG3RD4UfkE5S/XFWYKyC+5qeFnN2k5lY7gOzGAT7tXzJzFGN+Df8HtjiVpqEQGhnOs=
X-Received: by 2002:a7b:cd17:0:b0:3ed:526c:25cb with SMTP id
 f23-20020a7bcd17000000b003ed526c25cbmr8250302wmj.8.1680522619341; Mon, 03 Apr
 2023 04:50:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:6411:0:b0:2d4:d74d:fc8b with HTTP; Mon, 3 Apr 2023
 04:50:18 -0700 (PDT)
Reply-To: susanmoyamba1@yahoo.com
From:   Susan Moyamba <barristerartinamza@gmail.com>
Date:   Mon, 3 Apr 2023 11:50:18 +0000
Message-ID: <CAJ-GRB6+f5x2o5E5vekPAy1zi044DOHRB3_AcgcFsVZsmYT_ww@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good day

How are you doing today. I will like to do business with you.

However, I have investment fund  i will like you to receive and move
it into your country for investment purposes..

Please kindly get back to me so that i will discuss about the
transaction and forward you the procedures.

I await for your response together with your details to enable us proceed

Your Sincerely
Susan Moyamba
