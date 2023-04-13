Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F26E0895
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjDMIHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDMIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4116419A;
        Thu, 13 Apr 2023 01:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D068661842;
        Thu, 13 Apr 2023 08:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FC6C433D2;
        Thu, 13 Apr 2023 08:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681373228;
        bh=bneuiq+BJEg4YrqzCk04SX5/fRewiovbs5vJxL8hDrs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A5452YxLvQVE0aNy2PPvGWGe1q4uN3adLjNWje2u5pCZr60fl1JSCj8dTdksqmwKm
         iggz4KlDHhvHHaBYZb5b9ujUE60PxtJPM03n0eN/dmyI3+qr4PqUMKyUSodlinr8ku
         rcLYNXLvU1Chx7Wm8qvhDUON8xwVdEkGzffTfEv/6zJjgRxIu+udrGwaANWYxAy/Z2
         GP4IxoMzdq56AhEHeFDMz9r/nQjJ4CkASj1sEXbza3bmcXQ70J31VTZ1hF8poO4aS8
         s38+wgDF0YpTkBqGrGw7X8oOoqiC7J4TfUTlKNxk7aJqNRHID2SZVS3woGO0/LFBgB
         5NnSMKjJrLBxg==
Message-ID: <501892f8-cad3-d1c7-7d24-6226eefe7edd@kernel.org>
Date:   Thu, 13 Apr 2023 10:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 6/6] dt-bindings: iio: st-sensors: Add LSM303D
 accelerometer+magnetometer
Content-Language: en-US
To:     Marius Hoch <mail@mariushoch.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>
References: <20230413024013.450165-1-mail@mariushoch.de>
 <20230413024013.450165-7-mail@mariushoch.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230413024013.450165-7-mail@mariushoch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 04:40, Marius Hoch wrote:
> Same as the lsm9ds0, except that the lsm303d doesn't
> feature a gyroscope.
> 
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Best regards,
Krzysztof

