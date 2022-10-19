Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0F560459A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiJSMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiJSMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:42:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893AF900E0;
        Wed, 19 Oct 2022 05:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgxWgchJuJ6Dw50LdT0NY943TVSfA38S6k5LNrUK20fLGxogj2os9cY2RHstpAyTjX+jmiBioWcjG9WFPZDG7Q+Yq0TzbeJw9UVBgK4pMHpNMWftJKrr6wjy1jqGek8zMIJ75bJXSxassbhwjtue/HpxPYNI1ri7k+n9dKqAtRvwzRwAGley3U61czFvm+m4lFxaEg0xa5eYv8j/6h2qniKriyw6iSjpQ2x7The/vc4FFhx4/g76sxAKD4iEAS2JQfNKmo0qIiSvv/JVHtR7cEbeACDBbtsZbIpE+82RTR8Td/OYOnmcVzpEyGahwE+ZqqqhLCVhehYbxl/T7yB5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSAoJaIP7lHZrsHNUZVHGz7mmhstQA4FyTsqpIMw82w=;
 b=D5kfvyC1lBYS3lJJBdxCvq9SqV4DzO2qleYGwKkoeARhxgAmdFDR8uOB+GiS2fnD8EkaYeQiyfBSo8O2j7iXtLCK0oyr61mg8vEpKiJxUMvH6jqY0/UwnE842C1HGaQcJCAVBgP/xNHQY+EgPrZYgbCEZPsnhDhacsS1RAninnN8d8N/e/zg8DeENyxzU8ZA2edsEUJKgQVN9EHPCfhPZ1uGQ+wAAd5bauBjwL7NcSMcZf1smOSbWfOs/ZIrEtU5lg2Ltnk7ePwwbonZR4cQc/iP4pV+f8ndBrG2G/FuQ7gYu+YTf7JDw0OMn8004iYyUv6KutjSD+CeV1uAlB/Y4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSAoJaIP7lHZrsHNUZVHGz7mmhstQA4FyTsqpIMw82w=;
 b=Hyt3i7nABzo1VtiyP5kAoIualcSU3JpD1jmFJ6LbzFb60q7Uc3SrVN5HmI63fhDz3lXONdjz8Lj446Jsn69x90ND3Fiysyqjr/sQKmH6OIbydmDdWwR4SjA76g75xdQuDidQKdFCSGhieXYLg9/CJPyRm7Zh/1RpAQb2JSGL5nETtyaHxpmorD18zsAqjj6Duac6cPuSYoKDdKO0TQcsAUfSplf3svYIOMdmWcM7LKYSPNcCPn4G2z4YsmiwE1pQLYxAgVoBkk67idgpY+g9yUJplfwoPmv0m/o640xxLPjY8KBOFOXaYXcC/0b40zeJ1j2tbh8oY0XRBJXicb25Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DU2PR04MB8903.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 12:00:57 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115%2]) with mapi id 15.20.5723.030; Wed, 19 Oct 2022
 12:00:57 +0000
Message-ID: <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
Date:   Wed, 19 Oct 2022 14:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 3401b5ae-e156-4938-71ba-08dab1c9949e
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgkBjJs5LkZJiixJ0OLL2ikaYZsY9jNRid9JuVqAYYFWawr0PhNepgMx1C+sNagbCMrr//NHV587Y9FEDIoIJiMyts+Em93FfvEQRbpoaYPkB8+AQCScjppXb5ebqxORKbZLlaG1PRf5+MtA98ank5/kPBqo3JA0Xnh8UvbSD6hJPEm3knius5P7wR/j63KD9W1I3SWutUOHmFxiNapfChV0b2NyGK7PuYWjqyuBT1HPJzo9GxqOGU/Q8Zteaq/s5iVKM/aWlcMrb5azp9nVNNTROsgUJVNmZJ/WZLcs07utyRkvasUFQOme3pq3S1Uzjl+Ai02pkq9U66N3trsMv79NHs/7GiseLAsgtVXkenoszn3Tnxk8VSkMOYBAz4dBe+Fu3dee9C0coV/bpJ7orLKELInA07uyjO5nGJwN9uiIupfabXtTOX/ul7IqUoJK9m9wFp8gVGoQKUaIRLO21YEUe8CQ3hlIMka1GXqQYhYDLsGYqe0BT54P0OyZKlOP4k1am7zrWDWYerHfBjTCmljmFgTGe6ys2vQgE3d/DeQHFgAtSSsf6N/nnqkq39PxNIsuQsvByRPXZMPdWKiJrP8QqGOrV3FfOLzje04+AGzq/WbQk8dHSh60VhghRlxbuKw+DEQbA89B9RnpFRIf5ceJXRFTi5QObStPVgAS4Zoa3m0evMouBvfVDB6RzDtrd6uwlIs2dMzZr9VQZJwGh2o4BZNl+zHSZT4Zn01sHy77czKQxKTpI9+0bV5lvkLTXh6pSLleJuwU3RI55cUHzGB4GSpgz4G3/QGKyP7rBXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(38100700002)(36756003)(86362001)(31696002)(31686004)(186003)(83380400001)(53546011)(110136005)(8676002)(26005)(6486002)(316002)(55236004)(44832011)(41300700001)(478600001)(4326008)(66476007)(8936002)(66556008)(66946007)(5660300002)(2906002)(6506007)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akdOeEFGSUlVQVZlN0NxVkROOFp3WW1STXdQUStGRXphaVFrbXdwOG5peTJ1?=
 =?utf-8?B?UFdWdEhZdzFtV2pCN1RlMmZWZDVwVVVNcTQ4NHJRRWwyZTZWY1ppSldKSHph?=
 =?utf-8?B?dkdoVjNkbnRQdE9BQW1ZdUEzNnZraVNteXpoa3IydHU1eXpFL2lONm1mMFMy?=
 =?utf-8?B?WE03S2NnU2h0V1gzNWNpOWJXUnplVDNvZUZyNkJGRDFXUHp0ank5RTlkTWJw?=
 =?utf-8?B?Y3NxcHllakNRQndjMVh5L3JlMHBFNVJOY29ReGdzd1dlVThydTRNUGM1V2Zr?=
 =?utf-8?B?azNBNWVQVzVvWXJEOWxEV0MzWm5sdWxmbFUyYjlrbjJrSDdFZENIcW9zbG5m?=
 =?utf-8?B?NHdoR2RyTktDQkdRaEFGREN6c1hlRHdiL2Q4MHIxYXlXd3Bhb2lQdU1OSWNu?=
 =?utf-8?B?M3czeGJIaTFWY3YwdFFISzZSOExRcWtMVjVYcW56TVhqSG55MGNxTUNmeTZK?=
 =?utf-8?B?d2NYc0M1dURLNUNTTUtCalBnMGN5ZFFjeVdNa041bzJtT0R3R3FCV3FldXdj?=
 =?utf-8?B?b0tqSkU0OVBqNVNzT2M2ck1vcWV2N2Vqa0pWMTFFTUw4eTcyc2d1VUNZVENT?=
 =?utf-8?B?VjM2Ui9pY0Q1bE5GUjNLTUFRcDk5MnAyU3lnb1dJazJKWk5sV0ZGVVV3K2Jw?=
 =?utf-8?B?OVNOWFcyaXg1dlE3WFlabVBJNGZ3NUV4WU9LdEtaRnZzKzFOYUxSbjJmWnNX?=
 =?utf-8?B?L3pvRTd4QUxPczNrTmJJcW83aHlNbzRrNEp0WUw2by9mbnYrcGVCUlF4eEI5?=
 =?utf-8?B?a1paRUNORnpiS251cDJwdXIxSW9QSnp6dlM4TmxLZW9IUkduUlBpU29qMUNR?=
 =?utf-8?B?NUVUQXNFTENac3hlM3hQbUh5VkQzYmN0MFJSRWdLYjRQcXNTUUprWm8vOWpq?=
 =?utf-8?B?S1RtWEQrVlRIaGIrUDh0Rys5Wi9xR0U4QWhkeWJXODdLaWxYNXNFc2ZoTTJQ?=
 =?utf-8?B?b3FaN3VqOFVMSnZtaW1mVmFFcFpnQ3huaEdtb1FKTFlNc3FOQ3h5YjhzZGJm?=
 =?utf-8?B?ZzNqa244NUk0VUhTZjZNTC9RYlQrb1pScWV6NlVwanNZWEQ1SGRtNjV3bW9p?=
 =?utf-8?B?R2V0cGVtNW5qMi9mYlBqbUtYUG0veXUyWFhZbzR0WWh6MXJIYWUrdjRPOEFU?=
 =?utf-8?B?aFZ2ako5WlZoZUU4N0hwa2dEaXphYTh4TXRzYTRuZkpEcXNkZlhZck5CeFVr?=
 =?utf-8?B?Ny95M2xVUks1NFA1WlZEMVp1cU1Qa0ZRd3lMYWJvKzB2MGxkWW9DR0VhZk9F?=
 =?utf-8?B?Zmw2cC9NT08wTDVvWUZvYnJnVnVxS1Q3QUJ6S01UYjljRHB3Y2lFbFk3QWd6?=
 =?utf-8?B?emJIcGV1aTBsekFXZ2VBd1ZQY0ZwbkV4Q3FtdUZIdy9LTExLYVF3S0ZjRmto?=
 =?utf-8?B?d0pQVCt4eWMvNU1jaGg1NDhGYWhsT0EvQ09BVEJQZ1ovU0xQbHVqY2krcXV0?=
 =?utf-8?B?UlVuR2lwTWlSVXJKQ3lXcitCays3L2xtcjFzVVJON2dZaDdzUTZKRzcxWlV5?=
 =?utf-8?B?REtqWW9MTzh1NlFMeWJCbURFKzFFbEoyZFVUSU9OV2JyTGRDUFpwWW4wcHd6?=
 =?utf-8?B?RWM4bUp3cFhsTFVhMllpcDMxOXIyUkhlYlh0SS8yeTl2OW51MEovS241VGpL?=
 =?utf-8?B?amo5SlhhVEZMNkxOSHJXN2kwQjZieituc2NPTTVRZGF6b2pYZXhzMlMvZ2p5?=
 =?utf-8?B?K2ErbWZqT0lxNWVJOVUxeGhTSkp0M210QVZHTnNkSmRjckE1TFcrUlE1b2Qv?=
 =?utf-8?B?YitPbWVPeFZGRm13UEVDb3R5Q2lPMHhtM2NGVm5Zd0ViQWN1TmZubGwyNk9P?=
 =?utf-8?B?TkxWV2tVUEF0NU1RbHd1THVxTW51dms1ZTczLzZvaVM4SHBNd1BhSnNZOFEv?=
 =?utf-8?B?RWZWSExMb3FVK2FYdFZ5STJOWlNFSU9lbDVLckE3bkErdXFSekk3TXNUOVNZ?=
 =?utf-8?B?K2lYV3p6a2kzak5EWHJwaFZMVGJDRVUyS1h6T3Z3TTFBcUE5UWtBcEgwYm5D?=
 =?utf-8?B?QkU4bldVaVExc3l3YTQ5OW1WZ3ZCUThoK2xOamhtSVVWVDM4a1ZyRXVjejdX?=
 =?utf-8?B?TFBNUlQ1eGdYTjRnYVZpU3ZJS2FlQVRJcXdTejZJSEFML0luWDZpV1h4TGZx?=
 =?utf-8?Q?dt4gnwwHW2uxRwEcKhi8a5Grg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3401b5ae-e156-4938-71ba-08dab1c9949e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:00:57.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNpAJHVHfkcimAAE/vi2BpaIoMSePwaSAz8JyGGt/Uiox6PfWr91EwN1uMFB5U04R/4q73oKCHy1R7HIoPfgDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 20:33, Luis Chamberlain wrote:
> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>> The patch does address a regression observed after commit 6e6de3dee51a
>> ("kernel/module.c: Only return -EEXIST for modules that have finished
>> loading"). I guess it can have a Fixes tag added to the patch.
>>
>> I think it is hard to split this patch into parts because the implemented
>> "optimization" is the fix.
> 
> git describe --contains 6e6de3dee51a
> v5.3-rc1~38^2~6
> 
> I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
> right thing to do, but without it, it still leaves the issue reported
> by Prarit Bhargava. We need a way to resolve the issue on stable and
> then your optimizations can be applied on top.

Simpler could be to do the following:

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d02d39c7174e..0302ac387e93 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
 	sched_annotate_sleep();
 	mutex_lock(&module_mutex);
 	mod = find_module_all(name, strlen(name), true);
-	ret = !mod || mod->state == MODULE_STATE_LIVE;
+	ret = !mod || mod->state == MODULE_STATE_LIVE
+		|| mod->state == MODULE_STATE_GOING;
 	mutex_unlock(&module_mutex);
 
 	return ret;
@@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module *mod)
 	mutex_lock(&module_mutex);
 	old = find_module_all(mod->name, strlen(mod->name), true);
 	if (old != NULL) {
-		if (old->state != MODULE_STATE_LIVE) {
+		if (old->state == MODULE_STATE_COMING
+		    || old->state == MODULE_STATE_UNFORMED) {
 			/* Wait in case it fails to load. */
 			mutex_unlock(&module_mutex);
 			err = wait_event_interruptible(module_wq,
@@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module *mod)
 				goto out_unlocked;
 			goto again;
 		}
-		err = -EEXIST;
+		err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
 		goto out;
 	}
 	mod_update_bounds(mod);

This is an alternative approach to fix the issue that 6e6de3dee51a addressed
and it preserves the previous handling of same-module parallel loads.

It works well in practice but a problem is that this previous handling is
somewhat fragile because it requires specific timings. A second load of a same
module returns EBUSY only if it observes the first load in the going state.

The following can then happen:
* A first load of module A is requested. It passes add_unformed_module() and
  proceeds with full initialization.
* A second load of module A arrives. It proceeds up to add_unformed_module()
  where it waits on the first module to complete its initialization.
* The first load fails because its init function happens to produce an error.
  The cleanup code in do_init_module() unlinks the module from the modules
  list, frees the module and finally calls wake_up_all(&module_wq).
* The second load gets woken up. It sees that there is no module with the same
  name in the modules list and continues with its full initialization, which
  likely again fails in the init function.

This scenario can be reproduced when one prepares a sample module with
"msleep(1000); return -ENODEV;" in its init function and tries to load it
several times in parallel.

My posted patch essentially brings this handling of parallel loads back but
gained some extra bits as I wanted to prevent the described instability.

However, as mentioned previously, if we can avoid these parallel same-module
load attempts in the first place then that would be certainly the best option.

Thanks,
Petr
