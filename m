Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388586DC680
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDJMEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:04:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3A59C1;
        Mon, 10 Apr 2023 05:04:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so3073069pji.1;
        Mon, 10 Apr 2023 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681128262; x=1683720262;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSCp5sXN8xStsRN7SVmSAX5XG7cVX4BPej71ecCmpa0=;
        b=li4Q3QtD4+LQpQ0PQk7DpCXsN+NnmwUDDeUeo//pf3qZXtCoodWCxga7dyLJk86J+l
         63/Cslbx8+ZTvjxvQvHNGE9T3FvJJvAlp9n/O6JNlqeUoOaaCDVS7wyIAJAC/XUB67gv
         lZ1ZiPBsxdVSI6ETBVYehI1E8HPnVXF2D+ewGnp+7/quYYGHZqGKbq6bWa2Lkpo3Ru4V
         qptLcMVX/VaDM2JS7uVLPaw/y/ydBrBD7ND4yiaLgzwVVqxJmjlzWTIMy29k7phrgpE1
         rxcqCLnf1AIhnLySInhZFbCb1/pefM0Mduaewvsjxd77rlSNp1rVvYrTHm9Rwzh9p59o
         ETQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681128262; x=1683720262;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSCp5sXN8xStsRN7SVmSAX5XG7cVX4BPej71ecCmpa0=;
        b=ZBqi1wJP5Cpx928hqcSA7YsP/N1E57rr/eQSNEZzNE+5qQ9pz3ssD8AMcaLY/GrX/c
         +qgvXZlvctDE3fY3SFby62Uz7zYKJ+PyOFMicmqtW8hqw6ia+3wHzzurs8fxlVsbLDVW
         PqpU1ONFUyip3N1OwmUHwgS9XMTAaf3GHMGQxep8dCxxmZOqOQ7iiy2SrCNTt4pQ+h2M
         tvttgv71RnYWyDF6FfpE0g8oJPWhX/vfWx3H0ae0taN41ABxSFZydx++odeFMlaaP2Lf
         VZlcYQagSExFpDMWEp1ZHPl19YeHIazehk5eZgzBMZeTAAnPcNwalkqdLXh45+troXC3
         itrA==
X-Gm-Message-State: AAQBX9e7Kyr0zdPs9tGvSjMi5BuOCVvCqILFQ7CZjETD8EOCZlis9xqQ
        NumPQN9A3iRLyQSKw7kMWKg=
X-Google-Smtp-Source: AKy350ZJ/UjG7TDZ5PenKcDpA6YGSTd9gB3A69ervu6XQxm2CAi/JVk6ZIqKd1dzJZRCJQXDasUrwA==
X-Received: by 2002:a17:902:ecca:b0:1a1:ab85:1e1e with SMTP id a10-20020a170902ecca00b001a1ab851e1emr10942970plh.22.1681128262353;
        Mon, 10 Apr 2023 05:04:22 -0700 (PDT)
Received: from [192.168.127.3] ([103.133.200.235])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902bcc200b001a1ca6dc38csm7628551pls.118.2023.04.10.05.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 05:04:21 -0700 (PDT)
Date:   Mon, 10 Apr 2023 18:04:11 +0600
From:   Mubashshir <ahmubashshir@gmail.com>
Subject: Re: [PATCH v2] staging: HID: Add ShanWan USB WirelessGamepad driver
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Huseyin BIYIK <huseyinbiyik@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Message-Id: <ZUEWSR.82P557C7XBKX2@gmail.com>
In-Reply-To: <f2e84ed47b84847c7e555c871d9851c6d70d6964.1681127968.git.ahmubashshir@gmail.com>
References: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
        <f2e84ed47b84847c7e555c871d9851c6d70d6964.1681127968.git.ahmubashshir@gmail.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10 2023 at 05:59:30 PM +06:00:00, Mubashshir 
<ahmubashshir@gmail.com> wrote:
> +MODULE_AUTHOR("Ahmad Hasan Mubashshir <ahmubashshir@gmail.com>");

Sorry, I missed the semicolon here on my previous patch.


