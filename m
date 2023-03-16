Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04AB6BCB38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCPJmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCPJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:42:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7724499
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:42:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z21so5100835edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678959729;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZVkFn3YwdxEdThkVHM6Q9Cxc1dE09qwtEAvH/ySM1g=;
        b=BiXpoSYtdlYvtZd4H44tgevTmRdxIWbx935MR1DMqF8FiWmxJzSNAgSWAj6HN4Jjcq
         +0DBVBhTSb1CM0VVo8OYysxJDOQz6O03izU6JHojBxsJurZGSB3BvQhwqHQwIaq1vvFY
         gtlpTLWYZsOku/oLIQsp3bZpFy9y26CHJ8vy5LAJhXAhdzr4JYhMGwmig0gI7F1g31hi
         JX+X8nbhrG15mM42RkMuI2O2nrzzEdgcVwS2u5YdRF2kTp34Zm33tDmbg0O/uqMYc7Q9
         7yQFQoDIjhkB3RrjJv6KeDF35uvAq9v+skDz//uwRf+LI9YMReYD1rBI10ykV7rBfTzs
         XXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678959729;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZVkFn3YwdxEdThkVHM6Q9Cxc1dE09qwtEAvH/ySM1g=;
        b=jQiVGPEJHBSOQ2cQVmaChz9wloeZYy8lte8DFsc14q3PRBSwuZsR7DSui9JAocSnxS
         pNFUwBKoCZalt7RdMtqHK+017VZV76XFmQ8OVoTORKSqDjTHt7iI81hpc7m5Aw0Sa4Ov
         SK4oHOVNdF3jrXqT82FRllvMUzYVhGIVaw+GiC8tQw3VWybLXhV5Eft9HMjDav55Xsbd
         ZokQMvPLrnsgsozfNchYHcnKwrBngl2Umg19ZlfcEVsfU7Wm1HOucXrDYSc19NCt9bUD
         7tGXNdtbFiBHLh6+ZfkZpNXChx4WRlmwqjQBAlP6g58maa21PhhLbMeCl2tk28ZMB0tg
         ajyA==
X-Gm-Message-State: AO0yUKWs4MpMpTaULrmc/DrM80t44xRhM9CmfjtrPpfniuG3gwkX6VKI
        oNpbL2eeR6qm070YbOsKqjy9NvX+7iwghoMqmdMtxP7S75V9xA==
X-Google-Smtp-Source: AK7set8TsSwlQ/eQ31it5LAFeZ2+JjT+aBoTxOaZ0MBJwtV7jjj1LMQ/uMInKUUgCMAHYLKGvI/dEyM6dL1F997mtbQ=
X-Received: by 2002:a17:906:1f53:b0:879:5db8:8bb2 with SMTP id
 d19-20020a1709061f5300b008795db88bb2mr4320892ejk.7.1678959729902; Thu, 16 Mar
 2023 02:42:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:1c:b0:4a:6d91:4bb3 with HTTP; Thu, 16 Mar 2023
 02:42:09 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <otawo2019@gmail.com>
Date:   Thu, 16 Mar 2023 09:42:09 +0000
Message-ID: <CAB9VptTSDai7ohV7zEeMo2T7wzTiR5j3+SPAO6hJwi8-CEY8gA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9980]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [otawo2019[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [otawo2019[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylam28[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
Please did you receive my previous letter? write me back
